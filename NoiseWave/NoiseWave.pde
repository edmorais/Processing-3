/*
   ____   __                 __       __  ___              _   
  / __/__/ /_ _____ ________/ /__    /  |/  /__  _______ _(_)__
 / _// _  / // / _ `/ __/ _  / _ \  / /|_/ / _ \/ __/ _ `/ (_-<
/___/\_,_/\_,_/\_,_/_/  \_,_/\___/ /_/  /_/\___/_/  \_,_/_/___/
 
 * NoiseWave
 * by Eduardo Morais 2019 - www.eduardomorais.pt
 *
 * Press space to toggle horizontal / vertical drawing
 * 
 * After the Perlin noise tutorial at
 * https://necessarydisorder.wordpress.com/2017/11/15/drawing-from-noise-and-then-making-animated-loopy-gifs-from-there/
 */

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

float[] noisey; 
int reso = 3;
int size_mult = 1;
Minim minim;
AudioInput in;
boolean horizontal = false;

void settings() {
  size(720*size_mult,720*size_mult);
}
void setup(){
  background(255);
  noFill();
  strokeWeight(size_mult);
  smooth();
  frameRate(60);
  noisey = new float[width];

  /* Init microphone */
   minim = new Minim(this);
   in = minim.getLineIn();

}
 
void draw(){
  background(255);
  float scale = 0.005;

  int large = width;
  int small = height;
  if (small > large) {
    small = width;
    large = height;
  }

  /* 1D Noise */
  for (int i = 0; i < large; i += reso*size_mult) {
    // int bpos = int(map(i, 0, in.bufferSize(), 0, large));  // pos
    noisey[i] = small*(noise(scale*i, frameCount*scale)+in.mix.get(i)/4);
  }

  for (int i = 0; i < small/3; i += 10*size_mult) {
    float cn = norm(i, 0, small/3);
    stroke(lerpColor(color(0,0,255),color(255,0,0),cn));
    beginShape();
    if (horizontal) {
      for(int x = 0; x<large;x+=reso*size_mult){
        vertex(x,noisey[x]+i-small/6);
      }  
    } else {
      for(int y = 0; y<large;y+=reso*size_mult){
        vertex(noisey[y]+i-small/6, y);
      }
    }
    endShape();
  }

}

void keyReleased() {
  if (key == ' ') {
    horizontal = !horizontal;
  }
}