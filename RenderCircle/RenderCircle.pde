/*
 * Draw a Circle the Hard Way
 * by Eduardo Morais 2019 - www.eduardomorais.pt
 */

float r = 150;
int x = 0;
int y = 0;

void setup () {
  size(320,320);
  background(0);
  stroke(255);
  fill(255);
  frameRate(120);
  x = 0 - width / 2;
  y = 0 - height / 2;
}

void draw () {
  translate(width/2, height/2);
  
  float sqxy = sq(x) + sq(y);
  
  println(sqxy, sq(r));
  
  if ( sqxy < sq(r) - 100 || sqxy > sq(r) + 100 ) {  
    point(x, y);
  }
  
  x+=2;
  if (x > width /2) {
    x = 0 - width / 2;
    y+=2;
  }
  
}