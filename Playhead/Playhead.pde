/*
 * Playhead
 * by Eduardo Morais 2019 - www.eduardomorais.pt
 */


import processing.sound.*;

TriOsc oscil, oscil2;
Env env; 

int plhead = 1000;
int notesnum = 32;
Dot[] notes;
float v = 2;
float[] freqs = { 
  261.63, 293.66, 329.63, 392, 440, 523.25, 587.33, 659.26, 783.99, 880 };
  // frequencies (Hz) corresponding to two octaves in the pentatonic scale (CDEGA)

void setup() {
  size(1200, 800);
  background(255);
  oscil = new TriOsc(this);
  oscil2 = new TriOsc(this);
  env  = new Env(this); 
  
  notes = new Dot[notesnum];
  for (int i = 0; i < notes.length; i++) {
    float ny = map(i, 0, notes.length-1, 50, height - 50);
    float nvel = random (0.5, 1.5);
    color nc = color(random(0,150),random(50,150),random(50, 255));
    int nf = int(random(0, freqs.length));
       
    //   Dot(float px, float py, float pvel, color pc, float pd, float pfreq) 
    notes[i] = new Dot(random(-width, -50), ny, nvel, nc, random(30, 50), freqs[nf]);
  }
}


void draw() {
  fill(255,30);
  rect(0,0,width,height);
  
  // update
  plhead = mouseX;
  for (int i = 0; i < notes.length; i++) {
    notes[i].update(v);
  }
    
  // display
  stroke(255,0,0, 16);
  strokeWeight(2);
  line(plhead,0,plhead,height); // playhead 
  
  int cur = 0;
  for (int i = 0; i < notes.length; i++) {
    cur += notes[i].display();
  }
  if (cur > 0) { cursor(HAND); } else { cursor(ARROW); }
  
}

void keyPressed() {
  if (keyCode == LEFT && v > 0.5) {
    v -= 0.2;
  }
  if (keyCode == RIGHT && v < 4) {
    v += 0.2;
  }
}
