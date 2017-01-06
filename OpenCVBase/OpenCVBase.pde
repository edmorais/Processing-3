import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
int x = 0;
int y = 0;
int w = 0;
int h = 0;
int opacity = 0;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0, opacity);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();

  if (faces.length > 0) {
    x = faces[0].x;
    y = faces[0].y;
    w = faces[0].width;
    h = faces[0].height;
    opacity = 255;
    println(x,y,w,h);
  } else if (opacity > 0) {
    opacity -= 50;
  }
  rect(x, y, w, h);
}

void captureEvent(Capture c) {
  c.read();
}