class ThirdApplet extends PApplet {

  void settings() {
    size(200, 100);
  }
  void setup() {
    background(0);
  }
  
  void draw() {
    fill(255);
    ellipse(mouseX, mouseY, 10, 10);
  }
  void mouseReleased() {
    noLoop();
    this.getSurface().setVisible(false);
    this.getSurface().stopThread();
  }
}