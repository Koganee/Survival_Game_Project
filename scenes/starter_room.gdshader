shader_type spatial;
render_mode unshaded, blend_add, cull_disabled;

uniform float time;
uniform sampler2D swirl_texture;

void fragment() {
    vec2 uv = UV * 2.0 - 1.0;
    float angle = atan(uv.y, uv.x);
    float radius = length(uv);
    
    angle += time * 1.5;
    vec2 swirl_uv = vec2(cos(angle), sin(angle)) * radius;
    swirl_uv = swirl_uv * 0.5 + 0.5;

    vec4 tex = texture(swirl_texture, swirl_uv);
	vec3 purple_tint = vec3(0.6, 0.2, 1.0); // RGB for purple
	vec3 color = tex.rgb * purple_tint;

	ALBEDO = color;
	EMISSION = color * 5.0;
	ALPHA = tex.a;
}
