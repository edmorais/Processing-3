/*
 * Walker -- after The Nature of Code
 * by Eduardo Morais / May 2021 - www.eduardomorais.pt
 */

Ball[] balls = new Ball[25];

void setup() {
  size(1024,1024);
  for (int i=0; i<balls.length; i++) {
    balls[i] = new Ball(random(3,width/33)); 
  }
}

void draw() {
  background(#0000FF);
  for (int i=0; i<balls.length; i++) {
    balls[i].update();
    balls[i].checkEdges();
    balls[i].display();
  }
}


class Ball {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float dia;

  Ball(float pt) {
    position = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    topspeed = pt;
    dia = ((width/33)+3-pt)*8;
  }

  void update() {

    PVector mouse = new PVector(mouseX,mouseY);
    PVector dir = PVector.sub(mouse, position);
    
    float dist = PVector.dist(mouse,position);
    
    dir.normalize();
    dir.mult(map(dist, 0,2000, 1,0));
    acceleration = dir;
    
    velocity.add(acceleration);
    velocity.limit(topspeed);
    position.add(velocity);
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    noFill();
    ellipse(position.x, position.y, dia, dia);
  }

  void checkEdges() {

    if (position.x > width) {
      position.x = 0;
    } 
    else if (position.x < 0) {
      position.x = width;
    }

    if (position.y > height) {
      position.y = 0;
    } 
    else if (position.y < 0) {
      position.y = height;
    }
  }
}
