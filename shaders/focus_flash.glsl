const int COLOR_INDEX = 4;
const float DURATION = 0.35;
const float WIDTH = 40.0;
const float INTENSITY = 0.35;
const float STARTUP = 0.5;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec4 terminal = texture(iChannel0, fragCoord / iResolution.xy);
    fragColor = terminal;

    float elapsed = iTime - iTimeFocus;
    if (iFocus == 0 || elapsed >= DURATION || iTimeFocus < STARTUP) return;

    vec2 toFar = iResolution.xy - fragCoord;
    float edge = min(min(fragCoord.x, toFar.x), min(fragCoord.y, toFar.y));
    float glow = exp(-edge / WIDTH);

    float fade = 1.0 - elapsed / DURATION;
    float alpha = INTENSITY * glow * fade * fade;
    fragColor = vec4(mix(terminal.rgb, iPalette[COLOR_INDEX], alpha), terminal.a);
}
