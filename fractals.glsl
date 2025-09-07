vec3 colorA = vec3(1.0, .0, .0);
vec3 colorB = vec3(.0, .0, 1.0);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec3 red = vec3(0.0);

    float pct = abs(sin(iTime));
   
    
    
    fragColor = vec4(red,1.0);
}
