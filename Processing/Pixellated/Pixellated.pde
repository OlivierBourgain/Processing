  
import processing.video.*;

Capture cam;
int scale = 32;

void setup() {
  size(1280, 480);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
   } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println("" + i + " => " + cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();    
  }      
}



void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  

  for(int x = 0; x < cam.width / scale; x++) {
    for(int y = 0; y< cam.height / scale; y++) {
      float r = 0, g = 0, b = 0;
      for(int i = 0; i < scale; i++) {
        for(int j = 0; j < scale; j++) {
           int index = (x * scale + i + (y * scale + j) * cam.width);
            color c = cam.pixels[index];
            r += red(c);
            b += blue(c);
            g += green(c);
        }
      }
      color newcolor = color(r/scale/scale, g/scale/scale, b/scale/scale);
      float bright = brightness(newcolor);
      float w = map(bright, 0, 255, 0, scale);
      noStroke();
      fill(20);
      rect(x * scale, y * scale, scale, scale);

      fill(newcolor);
      rect(x*scale + (scale -w)/2, y*scale + (scale - w) /2, w, w);
    }
  }
  image(cam, 640, 0, 640, 480);
}