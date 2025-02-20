shader_type canvas_item;

uniform vec4 newColor : source_color;
uniform vec4 oldColor : source_color;
uniform float precision : hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 curr_color = texture(TEXTURE, UV);
	
	float dist = distance(curr_color.rgb, oldColor.rgb);
	if (curr_color.a < 0.1) {
		COLOR = curr_color;
	}
	else {
		if (distance(curr_color.rgb, oldColor.rgb) < precision) {
			COLOR = vec4(newColor.rgb, curr_color.a);
		}
		else {
			COLOR = curr_color;
		}
	}
}