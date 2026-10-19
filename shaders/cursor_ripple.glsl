const float DURATION = 0.4;
const float RADIUS_CELLS = 2.5;
const float THICKNESS = 2.0;
const float THRESHOLD_COLUMNS = 5.0;
const float THRESHOLD_ROWS = 1.9;
const int COLOR_INDEX = 3;
const float INTENSITY = 0.6;

float easeOutCubic(float t) {
    return 1.0 - pow(1.0 - t, 3.0);
}

vec3 effectColor() {
    return COLOR_INDEX < 0 ? iCurrentCursorColor.rgb : iPalette[max(COLOR_INDEX, 0)];
}

vec2 cellSize() {
    if (int(iCurrentCursorStyle.x) == CURSORSTYLE_BLOCK) return iCurrentCursor.zw;
    if (int(iPreviousCursorStyle.x) == CURSORSTYLE_BLOCK) return iPreviousCursor.zw;
    vec2 size = iCurrentCursor.zw;
    if (int(iCurrentCursorStyle.x) == CURSORSTYLE_BAR) return vec2(size.y / 1.8, size.y);
    if (int(iCurrentCursorStyle.x) == CURSORSTYLE_UNDERLINE) return vec2(size.x, size.x * 1.8);
    return size;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec4 terminal = texture(iChannel0, fragCoord / iResolution.xy);
    fragColor = terminal;

    if (iFocus == 0 || iCursorVisible.x < 0.5) return;

    vec2 size = iCurrentCursor.zw;
    vec2 halfSize = size * 0.5;
    vec2 current = iCurrentCursor.xy + vec2(halfSize.x, -halfSize.y);
    vec2 previous = iPreviousCursor.xy + vec2(iPreviousCursor.z, -iPreviousCursor.w) * 0.5;

    vec2 cell = max(cellSize(), vec2(1.0));
    vec2 cells = abs(current - previous) / cell;
    if (cells.x < THRESHOLD_COLUMNS && cells.y < THRESHOLD_ROWS) return;

    float progress = (iTime - iTimeCursorChange) / DURATION;
    if (progress >= 1.0) return;

    float radius = mix(max(halfSize.x, halfSize.y), cell.y * RADIUS_CELLS, easeOutCubic(progress));
    float fromRing = abs(length(fragCoord - current) - radius);
    float ring = 1.0 - smoothstep(THICKNESS * 0.5, THICKNESS * 0.5 + 1.0, fromRing);

    float alpha = INTENSITY * ring * (1.0 - progress);
    fragColor = vec4(mix(terminal.rgb, effectColor(), alpha), terminal.a);
}
