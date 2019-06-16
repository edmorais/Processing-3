/*
  Multiple Windows template
 */

SecondApplet sa;
ThirdApplet ta;
String[] args = {""};

void setup() {
  size(100, 100);
}

void draw() {
  background(0);
  ellipse(mouseX, mouseY, 10, 10);
  if (sa != null && sa.getSurface().isStopped()) sa = null;
  if (ta != null && ta.getSurface().isStopped()) ta = null;
}     

void mouseReleased() {
  if (mouseX < width/2) {
    if (sa == null) sa = new SecondApplet();
    PApplet.runSketch(args, sa);
  } else {
    if (ta == null) ta = new ThirdApplet();
    PApplet.runSketch(args, ta);
  }
}