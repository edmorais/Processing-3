/*
 * Gaussian -- after The Nature of Code
 * by Eduardo Morais / May 2021 - www.eduardomorais.pt
 */

import java.util.Random;

Random genera;

void setup() {
  size(1024,1024);
  background(#0000FF);
  fill(255, 64);
  noStroke();
  genera = new Random();
}


void draw() {
  float sd = 180;
  float num = (float) genera.nextGaussian();
  float x = sd * num + width/2;
  num = (float) genera.nextGaussian();
  float y = sd * num + height/2;
  ellipse (x,y,8,8);
}
