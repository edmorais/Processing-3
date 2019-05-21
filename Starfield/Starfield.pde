/*
 * Particle Starfield
 * by Eduardo Morais 2019 - www.eduardomorais.pt
 *
 * Drag mouse to recenter. 
 * C to randomize colors. R to reset (shift-R: hard reset).
 */


// config:
int 	NUM_PARTICLES 	= 8000;

/* snowfall */
/*
PVector EMMITER 		= new PVector(1280, 72);
PVector ORIGIN 			= new PVector(640, 0);
boolean CENTER_ORIGIN 	= false;
PVector	VELOCITY 		= new PVector(0, 2); // 0, 0 : away from CENTER
*/

/* starfield */
PVector EMMITER 		= new PVector(128, 72);
PVector ORIGIN 			= new PVector(0, 0);
boolean CENTER_ORIGIN 	= true;
PVector	VELOCITY 		= new PVector(0, 0); // 0, 0 : away from CENTER

float 	SPEED_MAX 		= 3;
float 	TURBULENCE 		= 0.3;
int 	LIFE_MIN 		= 200;
int 	LIFE_MAX 		= 1000;
int 	WEIGHT 			= 3;
color[] COLORS 			= {	color(255,0,0, 100),
							color(255,100,0, 180),
							color(255),
							color(255, 200),
							color(0,100,255, 180) };

PSystem ps;

int mode = 1;

void setup() {
		size(1280, 720);
		if (CENTER_ORIGIN) ORIGIN = new PVector(width/2, height/2);
	
		init();
		background(0);
}

void init() {
		// PSystem(int pnum, int pemit_w, int pemit_h, float pvel, float pturbo, int plife_min, int plife_max, color[] pcolors)
		ps = new PSystem(NUM_PARTICLES,			// particle NUMBER
						 EMMITER.x, EMMITER.y,	// EMMITER ORIGIN area
						 SPEED_MAX, TURBULENCE,	// speed range, TURBULENCE
						 LIFE_MIN, LIFE_MAX);	// min, max life			 

		ps.setWeight(WEIGHT);	// particle weight range
		ps.setColors(COLORS);	// set colors
		ps.start(VELOCITY);		// optional VELOCITY vector
}

void draw() {
		// trails thingy:
		fill(0, 64);
		noStroke();
		rect(0,0,width,height);
		noFill();

		// translate, update, display:
		pushMatrix();
		translate(ORIGIN.x, ORIGIN.y);

		ps.update();
		ps.display();

		popMatrix();

		if (mousePressed && CENTER_ORIGIN) {
			ORIGIN.x = mouseX;
			ORIGIN.y = mouseY;
		}
}

void keyReleased() {
		// random colors
		if (key == 'c' || key == 'C') {
			for (int i = 0; i < ps.colors.length; i++) {
				float ra = map(i,0,ps.colors.length-1, 100,255);
				float rk = random(0, 255-ra);
				ps.colors[i] = color(random(rk,255),random(rk,255),random(rk,255), ra);
				COLORS[i] = ps.colors[i];
			}
		}

		// weight
		if (key == 'w' && WEIGHT < 20) {
			WEIGHT++;
			ps.setWeight(WEIGHT);
		}
		if (key == 'W' && WEIGHT > 1) {
			WEIGHT--;
			ps.setWeight(WEIGHT);
		}

		// speed
		if (keyCode == UP && SPEED_MAX < 20) {
			SPEED_MAX++;
			ps.setSpeed(SPEED_MAX);
		}
		if (keyCode == DOWN && SPEED_MAX > 1) {
			SPEED_MAX--;
			ps.setSpeed(SPEED_MAX);
		}

		// reset
		if (key == 'r') {
			init();
		}
		if (key == 'R') {
			setup();
		}

		// switch mode
		if (key == 'm' || key == 'M') {
			mode = 0-mode;
			if (mode > 0) {
				EMMITER 		= new PVector(128, 72);
				ORIGIN 			= new PVector(0, 0);
				CENTER_ORIGIN 	= true;
				VELOCITY 		= new PVector(0, 0); // 0, 0 : away from CENTER
			} else {
				EMMITER 		= new PVector(1280, 72);
				ORIGIN 			= new PVector(640, 0);
				CENTER_ORIGIN 	= false;
				VELOCITY 		= new PVector(0, 2); // 0, 0 : away from CENTER
			}
			setup();
		}
}
