shader_type canvas_item;

uniform vec4 base_color : source_color = vec4(0.1, 0.4, 0.9, 1.0);

/* Darkness of blobs */
uniform float blob_strength = 0.18;

/* Size of blobs (bigger = larger blobs) */
uniform float blob_scale = 5;

/* Movement speed */
uniform float flow_speed = 0.2;

/* Direction of movement */
uniform vec2 flow_direction = vec2(1.0, 0.0);

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
           (c - a) * u.y * (1.0 - u.x) +
           (d - b) * u.x * u.y;
}

void fragment() {
    // LOCAL space → stable, editor == game
    vec2 p = UV * blob_scale;

    // Move noise in one direction
    p += normalize(flow_direction) * TIME * flow_speed;

    float n = noise(p);
    n = smoothstep(0.4, 0.75, n);

    vec3 color = base_color.rgb * (1.0 - n * blob_strength);
    COLOR = vec4(color, base_color.a);
}
