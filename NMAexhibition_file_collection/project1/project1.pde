float r_arc; //radius of arc
float r_sq; //radius of square

float angel_begin; //starting angel
float angel_rotate; //rotating angel
float angel_end; //rotating angel


void setup() {
  size(800, 650);
  frameRate(5);
  noStroke();
  background(255);
  rectMode(CENTER);
  r_arc = 80;
  r_sq = 100; //square is always a little bigger than the arc


}

void draw() {
  for (int i=0; i<800; i+= 150){
    for (int j=0; j<600; j+= 150){
        drawPie(i+r_sq, j+r_sq);
    }
  }
}


void drawPie(float center_x, float center_y) {  
  angel_begin = random(0, PI*2);
  angel_rotate = random(0, PI*2);
  angel_end = angel_begin + angel_rotate;

  fill(0, 0, 255);
  rect(center_x, center_y, r_sq, r_sq);

  fill(255, 0, 0);
  arc(center_x, center_y, r_arc, r_arc, angel_begin, angel_end, PIE);
}