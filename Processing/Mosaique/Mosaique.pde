  
import processing.video.*;

Capture cam;
int snapsize = 5;
PImage[] snapshots = new PImage[snapsize * snapsize];
int snapidx = 0;

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
    println("Camera started");
  }      
}

void takeSnapshot(Capture cam) {
  PImage snapshot = createImage(cam.width, cam.height, RGB);
  snapshot.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
  snapshots[snapidx] = snapshot;
  snapidx++;
  if(snapidx >= snapsize * snapsize) snapidx = 0;
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  
  if (frameCount % 3 == 0) takeSnapshot(cam);
  for(int i = 0; i < snapsize; i++) {
    for(int j = 0; j < snapsize; j++) { 
      int idx = (snapidx + i * snapsize + j) % (snapsize * snapsize);
      if (snapshots[idx] != null) {
        image(snapshots[idx], j * cam.width / snapsize, i * cam.height / snapsize, cam.width / snapsize, cam.height / snapsize);
        noTint();
      }
    }
  }
  image(cam, cam.width, 0, cam.width, cam.height);

}