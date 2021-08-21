  

PShader shd;

void setup() {
	size(640, 360, P2D);
	// Shaders files must be in the "data" folder to load correctly
	shd = loadShader("test.glsl"); 
	stroke(0, 102, 153);
	rectMode(CENTER);
}

void draw() {
 	shd.set("u_resolution", float(width), float(height));
 	shd.set("u_mouse", float(mouseX), float(mouseY));
 	shd.set("u_time", millis() / 1000.0);
	filter(shd);
	
}
