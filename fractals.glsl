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
out vec4 fragColor;

#define PI 3.14159
#define MAX_ITERATIONS 50

int mandelbrot(vec2 c)
{
  vec2 z = vec2(0.0);
  int iterations = 0;

  for (int i = 0; i < MAX_ITERATIONS; i++)
    {
      if (dot(z, z) > 4.0) break;
      z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
      iterations++;
    }

  return iterations;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv = uv  * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;

  vec2 c = uv * 2.0 + vec2(-0.5, 0.0);

  int iterations = mandelbrot(c);

  //gradient bg
  vec3 color = vec3(0.0);
  if(iterations < MAX_ITERATIONS)
    {
      color = vec3(1.0);
    }
  
  fragColor = vec4(color, 1.0);
}

void main()
{
   mainImage(fragColor, gl_FragCoord.xy);
}

