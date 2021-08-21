PVector loc; //<>//
PVector vel;

void setup() {
  size(768, 768, P3D);

  loc = new PVector(100, 100, 100); //<>//
  vel = new PVector(2.5, 5, 4);
}

void draw() {
  background(#0000FF);
 
  loc.add(vel);
  
  if ((loc.x > width-8) || (loc.x < 8)) {
    vel.x = vel.x * -1;
  }
  if ((loc.y > height-8) || (loc.y < 8)) {
    vel.y = vel.y * -1;
  }
  if ((loc.z > height-8) || (loc.z < 8)) {
    vel.z = vel.z * -1;
  }
 translate(384,384,-380);
 noFill();
 stroke(255);
 box(768,768,768);
 pushMatrix(); 
 translate(loc.x-384,loc.y-384,loc.z-380);
 sphereDetail(4);
 sphere(16);
 popMatrix();
  
}
