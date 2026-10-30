shader_type canvas_item;
uniform float scroll_speed;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 u = UV;
	u.x += scroll_speed * TIME;
	vec4 col = texture(TEXTURE, u);
	COLOR = col;
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
