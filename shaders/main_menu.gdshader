shader_type canvas_item;

uniform float scroll_speed = 0.6;
uniform float scroll_y_modifier = 0.24;

void vertex() {
	UV.x += TIME * scroll_speed;
	UV.y += TIME * -scroll_speed * scroll_y_modifier;
}
