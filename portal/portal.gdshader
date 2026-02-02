shader_type spatial;
render_mode unshaded, blend_mix, cull_disabled, depth_draw_always;

uniform sampler2D portal_texture;
uniform sampler2D noise_tex;

uniform vec4 portal_color : source_color = vec4(0.6, 0.8, 1.0, 1.0);
uniform float swirl_strength : hint_range(0, 10) = 4.0;
uniform float time_speed : hint_range(0, 5) = 1.0;
uniform float radius : hint_range(0.0, 1.0) = 0.5;
uniform float edge_softness : hint_range(0.0, 0.5) = 0.15;

void fragment() {
    vec2 uv = UV - 0.5;

    float dist = length(uv);

    // Swirl based on distance from center
    float angle = swirl_strength * dist * sin(TIME * time_speed + dist * 10.0);
    mat2 rot = mat2(
		vec2(cos(angle), -sin(angle)),
		vec2(sin(angle),  cos(angle))
	);
    uv = rot * uv;

    // Noise distortion
    float noise = texture(noise_tex, uv * 3.0 + TIME * 0.4).r;
    uv += uv * noise * 0.15;

    // Circular mask
    float alpha = smoothstep(radius, radius - edge_softness, dist);

    vec4 tex = texture(portal_texture, uv + 0.5);

    //ALBEDO = vec4(portal_color.rgb, tex.rgb, tex.a);
    ALBEDO = portal_color.rgb * (0.5 * tex.r + 0.5);
    ALPHA = alpha;
}