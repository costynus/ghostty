const float DESATURATE = 0.35;
const float DIM = 0.3;
const float FADE_IN = 0.2;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec4 terminal = texture(iChannel0, fragCoord / iResolution.xy);

    float amount = 1.0;
    if (iFocus != 0) {
        amount = 1.0 - clamp((iTime - iTimeFocus) / FADE_IN, 0.0, 1.0);
    }

    float luma = dot(terminal.rgb, vec3(0.2126, 0.7152, 0.0722));
    vec3 color = mix(terminal.rgb, vec3(luma), DESATURATE * amount);
    color = mix(color, iBackgroundColor, DIM * amount);
    fragColor = vec4(color, terminal.a);
}
