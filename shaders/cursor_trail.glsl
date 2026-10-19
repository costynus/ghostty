const float DURATION_MIN = 0.15;
const float DURATION_MAX = 0.45;
const float DURATION_MAX_CELLS = 30.0;
const float THRESHOLD_COLUMNS = 5.0;
const float THRESHOLD_ROWS = 0.9;
const int COLOR_INDEX = -1;
const float OPACITY = 0.6;

float easeOutCubic(float t) {
    return 1.0 - pow(1.0 - t, 3.0);
}

vec2 axisInterval(float p, float a, float d, float h) {
    if (abs(d) < 1e-4) {
        return abs(p - a) <= h ? vec2(0.0, 1.0) : vec2(1.0, 0.0);
    }
    float t0 = (p - h - a) / d;
    float t1 = (p + h - a) / d;
    return vec2(min(t0, t1), max(t0, t1));
}

float inSweep(vec2 p, vec2 a, vec2 b, vec2 h) {
    vec2 d = b - a;
    vec2 ix = axisInterval(p.x, a.x, d.x, h.x);
    vec2 iy = axisInterval(p.y, a.y, d.y, h.y);
    float lo = max(0.0, max(ix.x, iy.x));
    float hi = min(1.0, min(ix.y, iy.y));
    return lo <= hi ? 1.0 : 0.0;
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

    float duration = mix(DURATION_MIN, DURATION_MAX,
                         clamp(length(cells) / DURATION_MAX_CELLS, 0.0, 1.0));
    float progress = clamp((iTime - iTimeCursorChange) / duration, 0.0, 1.0);
    if (progress >= 1.0) return;

    if (all(lessThanEqual(abs(fragCoord - current), halfSize))) return;

    vec2 tail = mix(previous, current, easeOutCubic(progress));

    float coverage = 0.25 * (
        inSweep(fragCoord + vec2(-0.25, -0.25), tail, current, halfSize) +
        inSweep(fragCoord + vec2( 0.25, -0.25), tail, current, halfSize) +
        inSweep(fragCoord + vec2(-0.25,  0.25), tail, current, halfSize) +
        inSweep(fragCoord + vec2( 0.25,  0.25), tail, current, halfSize));

    float alpha = coverage * OPACITY * (1.0 - 0.5 * progress);
    fragColor = vec4(mix(terminal.rgb, effectColor(), alpha), terminal.a);
}
