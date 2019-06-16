class SecondApplet extends PApplet {

  void settings() {
    size(200, 100);
  }
  void setup() {
    background(255);
  }
  
  void draw() {
    fill(0);
    ellipse(mouseX, mouseY, 10, 10);
  }
  void mouseReleased() {
    noLoop();
    this.getSurface().setVisible(false);
    this.getSurface().stopThread();
  }
}