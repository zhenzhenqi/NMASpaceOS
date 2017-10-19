//declare two variables to control location of red pixel
float x1;
float y1;

float x2;
float y2;

float x3;
float y3;

//set up a new drawing environment
void setup(){
  //intialize values for two variable
  x1 = 300;
  y1 = 300;
  
  x2 = 250;
  y2 = 320;
  
  x3 = 310;
  y3 = 280;
  //set a background color with certain amount of red, green and blue
  //range 0 - 255
  background(0, 0, 0);
  //set a canvas that's 600 by 600 pixel big
  size(600, 600);
}

//things we draw that need to move around
void draw(){
  noStroke();
  //draw a rectangle at position x, y, with width and height
  fill(255, 0, 0);
  //draw an ellipse at random x y location, width and height predetermined
  rect(x1, y1, 10, 10);
  x1 = x1 + random(-10, 10);
  y1 = y1 + random(-10, 10);
  x1 = constrain(x1, 0, width);
  y1 = constrain(y1, 0, height);
  
  fill(0, 255, 0);
  //draw an ellipse at random x y location, width and height predetermined
  rect(x2, y2, 10, 10);
  x2 = x2 + random(-10, 10);
  y2 = y2 + random(-10, 10);
  x2 = constrain(x2, 0, width);
  y2 = constrain(y2, 0, height);
  
  fill(0, 0, 255);
  //draw an ellipse at random x y location, width and height predetermined
  rect(x3, y3, 10, 10);
  x3 = x3 + random(-10, 10);
  y3 = y3 + random(-10, 10);
  x3 = constrain(x3, 0, width);
  y3 = constrain(y3, 0, height);
}