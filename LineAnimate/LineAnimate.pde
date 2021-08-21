/*
  Quick demonstrations during a café conversation, 2019
  Think of this sketch as a napkin
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


  // monty hall problem quick monte carlo sim
  
  int change = 0;
  int nochange = 0;

  for (int i = 0; i < 10000; i++) {
    int door = round(random(0, 2));
    int choice = round(random(0, 2));
    int open = choice;
    while (open == choice || open == door) {
      open = round(random(0, 2));
    }

    if (choice == door) {
      nochange++;
    }
    if (choice != open && choice != door) {
      change++;
    }
  }
  println("No change: "+nochange);
  println("Change: "+change);
  
}

void draw() {
  if (s >= 0) {
    line(x1,y1,x1+xa,y1+ya);
    x1 += xa;
    y1 += ya;
    s--;
  }
}
