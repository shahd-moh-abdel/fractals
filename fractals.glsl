vec3 colorA = vec3(1.0, 0.0, 0.0);
vec3 colorB = vec3(0.0, 0.0, 1.0);

float plot (vec2 uv, float pct)
{
  return smoothstep(pct - 0.01, pct, uv.y) - smoothstep(pct, pct + 0.01, uv.y);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = fragCoord.xy / iResolution.xy;
  
  vec3 color = vec3(0.0);

  vec3 pct = vec3(uv.x);

  color = mix(color, vec3(1.0, 0.0, 0.0), plot(uv, pct.r));
  //color = mix(color, vec3(0.0, 1.0, 0.0), plot(uv, pct.g));
  //color = mix(color, vec3(0.0, 0.0, 1.0), plot(uv, pct.b));
    
  fragColor = vec4(color, 1.0);
}
