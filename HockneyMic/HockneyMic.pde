/*
 * Hockney - microphone controlled
 * by Eduardo Morais 2016 - www.eduardomorais.pt
 *
 */

import processing.video.*;
import processing.sound.*;
import java.util.*;
import java.text.*;

/* options */
int grid_x = 12;
int grid_y = 9;
int border = 1;
int buffer_max = 60;
float mic_level = 0.9;
int scale_factor = 2;

/* declarations */
Capture cam;
Movie vid;
AudioIn input;
Amplitude rms;
PImage[] buffer;

int cam_x = 640;
int cam_y = 480;

int jitter = 50;
int delay = 20;

PImage fragment = createImage(cam_x/grid_x, cam_y/grid_y, RGB);

int[] offsets_x = new int[grid_x*grid_y];
int[] offsets_y = new int[grid_x*grid_y];
int[] offsets_t = new int[grid_x*grid_y];

/* S E T U P */
void settings() {
  size(scale_factor * (border*(grid_x+1)+cam_x), scale_factor * (border*(grid_y+1)+cam_y));
}
void setup() {
  background(33);

  /* Init offsets & window */

  offsets();

  /* Init cameras */

  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[0]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);

    // Start capturing the images from the camera
    cam.start();
    buffer = new PImage[buffer_max];
  }

  /* Init microphone */
  input = new AudioIn(this, 0);
  input.start();
  input.amp(mic_level);
  // create a new Amplitude analyzer
  rms = new Amplitude(this);
  // Patch the input to an volume analyzer
  rms.input(input);
}

/* prepare fragment offsets */
void offsets() {
  for (int i = 0; i < offsets_x.length; i++) {
    int r_x = round(random(0-jitter, jitter));
    int r_y = round(random(0-jitter, jitter));
    int r_t = round(random(0, delay-1));

    if (i < grid_x) {
      r_y = round(random(0, jitter));
    }

    if (i >= grid_x*(grid_y-1)) {
      r_y = round(random(0-jitter, 0));
    }

    if (i % grid_x == 0) {
      r_x = round(random(0, jitter));
    }

    if (i % grid_x == 7) {
      r_x = round(random(0-jitter, 0));
    }

    offsets_x[i] = r_x;
    offsets_y[i] = r_y;
    offsets_t[i] = r_t;
  }
}

/* D R A W - - - - - */
void draw() {
  scale(scale_factor);
  /* camera */
  if (cam.available() == true) {
    cam.read();

    buffer[0] = cam.get();

    // move the framebuffer:
    for (int tx = delay-2; tx >= 0; tx--) {
      if (buffer[tx] != null) {
        buffer[tx+1] = buffer[tx];
      }
    }

    // copy grid fragments:
    for (int gx = 0; gx < grid_x; gx++) {
      for (int gy = 0; gy < grid_y; gy++) {
        int x = border + gx*border + gx*(cam_x/grid_x);
        int y = border + gy*border + gy*(cam_y/grid_y);

        if (buffer[offsets_t[gx*gy]] != null) {
          fragment.copy(buffer[offsets_t[gx*gy]], gx*(cam_x/grid_x) + offsets_x[gx*gy], gy*(cam_y/grid_y) + offsets_y[gx*gy], cam_x/grid_x, cam_y/grid_y, 0, 0, cam_x/grid_x, cam_y/grid_y);
          tint(255,255-2.5*random(0,jitter));
          image(fragment, x+(random(-jitter,jitter)/10), y+(random(-jitter,jitter)/10));
        }
      }
    }
  }

  /* microphone */
  if (rms.analyze() > 0.01) {
    delay = (int) map(rms.analyze(), 0, 1, 0, buffer_max);
    jitter = (int) map(rms.analyze(), 0, 1, 2, 100);
    offsets();
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && jitter <= 100) {
      jitter += 2;
    }
    if (keyCode == DOWN && jitter >= 2) {
      jitter -= 2;
    }
    if (keyCode == LEFT && delay > 0) {
      delay--;
    }
    if (keyCode == RIGHT && delay < buffer_max) {
      delay++;
    }
    offsets();
  }
}

void keyReleased() {
  if (key == ' ') {
    offsets();
  }

  if (key == 's' || key == 'S') {
    Date now = new Date();
    SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd_HHmmss");
    save("hockney_" + df.format(now) + ".jpg");
  }
}