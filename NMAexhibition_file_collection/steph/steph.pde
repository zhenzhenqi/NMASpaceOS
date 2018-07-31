import ddf.minim.*;

Minim minim;
AudioPlayer player;

/* preload="angrynyla.jpg and angersound.mp3"; */

PImage angry;
PImage[] lines;
float theta = 00.1;

void setup() {
  size(1920, 1080); 
    minim = new Minim(this);
  player = minim.loadFile("angersound.mp3");
  angry = loadImage("angrynyla.jpg");
  image(angry, 0,0);
  lines = new PImage[angry.height];
  for (int i = 0; i < lines.length; i++) {
    lines[i] = get(0, i, angry.width, 1);
    
  }
  mouseX = width/2;
}

void draw() {
  background(100);
  float amp = map(mouseX, 0, width, -100, 100);
  for (int i = 0; i < lines.length; i++) {
    image(lines[i], 
    ((width-angry.width)/2)+amp*sin(i*theta), i, 
    angry.width, 1);
  }
  theta += 0.005;
}

void mousePressed()
{
  if ( player.isPlaying() )
  {
    player.pause();
  }
  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  else if ( player.position() == player.length() )
  {
    player.rewind();
    player.play();
  }
  else
  {
    player.play();
  }
}
