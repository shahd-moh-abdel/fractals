#shader vertexShader
#version 430

in layout(location = 0) vec3 position;
in layout(location = 1) vec3 vertexColor;

out vec3 theColor;

void main()
{
  gl_Position = vec4(position, 1.0);
  theColor = vertexColor;
}

#shader fragmentShader
#version 430

uniform vec3 iResolution;
uniform float iTime;
uniform vec4 iMouse;
uniform float iZoom;
uniform vec2 iCenter;
out vec4 fragColor;

#define PI 3.14159
#define MAX_ITERATIONS 500

vec3 palette(float t)
{
  vec3 a = vec3(0.5, 0.5, 0.5);
  vec3 b = vec3(0.5, 0.9, 0.5);
  vec3 c = vec3(1.0, 1.0, 1.0);
  vec3 d = vec3(0.263, 0.416, 0.557);

  return a + b * cos(6.3 * (c * t + d));
}

float mandelbrot(vec2 c)
{
  vec2 z = vec2(0.0);
  float iterations = 0.0;

  for (int i = 0; i < MAX_ITERATIONS; i++)
    {
      if (dot(z, z) > 4.0)
	{
	  float log_zn = log(dot(z, z)) / 2.0;
	  float nu = log(log_zn / log(2.0)) / log(2.0);
	  iterations = float(i) + 1.0 - nu;
	  break;
	}
      z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
      iterations = float(i + 1);
    }

  return iterations;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = fragCoord.xy / iResolution.xy;
  
  uv = uv  * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;

  float zoom = iZoom;
  vec2 center = iCenter;

  if (zoom == 0.0)
    {
      zoom = 1.0;
      center = vec2(-0.5, 0.0);
    }

  vec2 c = uv / zoom + center;

  float iterations = mandelbrot(c);

  vec3 color;
  if(iterations >= float(MAX_ITERATIONS))
    {
      color = vec3(0.0);
    }
  else
    {
      float t = iterations / float(MAX_ITERATIONS);
      color = palette(t + iTime * 0.01);
    }
  
  fragColor = vec4(color, 1.0);
}

void main()
{
   mainImage(fragColor, gl_FragCoord.xy);
}

