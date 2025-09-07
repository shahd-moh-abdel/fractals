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
  vec2 mouse = iMouse.xy / iResolution.xy;
  
  vec3 color = vec3(0.8, 0.8, 1.0);
  //vec3 pct = vec3(sin(uv.x * PI));
  
  //color = mix(colorA, colorB, pct);
  
  //color = mix(color, vec3(1.0, 0.0, 0.0), plot(uv, pct.r));
  //color = mix(color, vec3(0.0, 1.0, 0.0), plot(uv, pct.g - 0.1));
  //color = mix(color, vec3(0.0, 0.0, 1.0), plot(uv, pct.b - 0.2));

  vec2 center = mouse.xy;
  float newCircle = circle(uv, center, 0.5);

  color = vec3(newCircle, 0.7, 0.7);
  fragColor = vec4(color, 1.0);
}
