/*
  Quick demonstration during a café conversation, 2019
 */

float x1, y1, x2, y2, xa, ya;
int s = 300;

void setup() {
  size(800, 800);
  background(0,0,255);
  stroke(255);
  strokeWeight(16);
  x1 = random(0, width);
  x2 = random(0, width);
  y1 = random(0, height);
  y2 = random(0, height);
  point(x1,y1);
  point(x2,y2); 
  strokeWeight(2);
  
  xa = (x2-x1)/s;
  ya = (y2-y1)/s;
}

void draw() {
  if (s >= 0) {
    line(x1,y1,x1+xa,y1+ya);
    x1 += xa;
    y1 += ya;
    s--;
  }
}
