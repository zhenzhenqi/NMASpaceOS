import processing.video.*;
import processing.sound.*;
import gab.opencv.*;
import java.awt.Rectangle;

ArrayList<PVector> points = new ArrayList<PVector>();
Word[] words = new Word[0]; 
Word myWord;
PFont f;

AudioIn input;
Amplitude rms;
OpenCV opencv;
Capture cam;
Rectangle[] faces;

int offsetX;
int offsetY;


void setup() {
  size(1920, 1280, P2D);
  //start capturing
  cam = new Capture(this, 640, 480);
  cam.start();

  offsetX = 1920/2-640/2;
  offsetY = 1280/2-480/2;

  //create the opencv object
  opencv = new OpenCV(this, cam.width, cam.height);

  //which "Cascade" are we going to use?
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  //opencv.loadCascade(OpenCV.CASCADE_EYE);
  //opencv.loadCascade(OpenCV.CASCADE_NOSE);
  //opencv.loadCascade(OpenCV.CASCADE_MOUTH);

  //create an input stream which is routed into the amplitude analyzer
  input = new AudioIn(this, 0);
  input.start();
  rms = new Amplitude(this);
  rms.input(input);

  f = createFont("Helvetica", 20);
}

void captureEvent(Capture cam) {
  cam.read();
}


void draw() {
  background(0);

  //we have to always "load the camera image into opencv
  opencv.loadImage(cam);

  //detect the faces
  faces = opencv.detect();

  //draw the video
  image(cam, offsetX, offsetY);

  //if we find faces, draw them!
  if (faces !=null) {
    for (int i = 0; i < faces.length; i++) {
      strokeWeight(2);
      stroke(255, 0, 0);
      noFill();
      //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);

      //the bigger the rms threashold, the harder louder the sound that needs to trigger the effect 
      if (rms.analyze()>0.01) {
        Word b = new Word(faces[i].x+faces[i].width/2+offsetX,faces[i].y+faces[i].height*0.8+offsetY);
        words = (Word[]) append(words, b);
      }
    }
  }

  //println(rms.analyze());



  for (int i = 0; i < words.length; i++) {
    words[i].move();
    words[i].display();
    words[i].fade();
  }
}
