class Word { 
  // Variables.
  color c; 
  float xpos;
  float ypos;
  float xspeed;
  float yspeed;
  float alpha;
  // A constructor.
  Word(float _xpos, float _ypos) { 
    c = color(175);
    xpos = _xpos;
    ypos = _ypos;
    xspeed = noise(-10, 10);
    yspeed = -3;
    alpha = 255;
  }

  // Function.
  void display() { 
    // The car is just a square
    textFont(f, 20);
    fill(200, 255, 100, alpha);
    textAlign(CENTER);
    text("words", xpos, ypos);
    //text("words", points.get(64).x, points.get(64).y);
  }

  // Function.  
  void move() { 
    xpos = xpos + xspeed;
    ypos = ypos + yspeed;
  }
  
  void fade(){
    if(alpha>0){
      alpha = alpha - 5;
    }
  }
    
}
