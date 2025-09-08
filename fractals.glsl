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

vec3 colorA = vec3(1.0, 0.0, 0.0);
vec3 colorB = vec3(0.0, 0.0, 1.0);

float plot (vec2 uv, float pct)
{
  return smoothstep(pct - 0.01, pct, uv.y) - smoothstep(pct, pct + 0.01, uv.y);
}

float borders(vec2 uv, float width)
{
  float left = step(width, uv.x);
  float right = step(width, 1.0-uv.x);

  float bottom = step(width, uv.y);
  float top = step(width, 1.0-uv.y);

  return left * right * bottom * top;
}

float circle(vec2 uv, vec2 center, float rad)
{
  float pct = distance(uv, center);
  return step(rad, pct);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = fragCoord.xy / iResolution.xy;
  uv = uv  * 2.0 - 1.0;
  uv.x *= iResolution.x / iResolution.y;

  //gradient bg
  vec3 color = vec3(0.1 + 0.1 * uv.x, 0.2 + 0.1 * uv.y, 0.3);
  
  fragColor = vec4(color, 1.0);
}

void main()
{
   mainImage(fragColor, gl_FragCoord.xy);
}

