Timer timer;
String cmd = new String("open -a Preview /Users/zhenzhen/Desktop/NMAexhibition_file_collection/test0.png");
String[] fileLocs = new String[3]; 
int index;


void setup() {
  size(200, 200);
  background(0);
  timer = new Timer(5000);//define a timer for 4 second long
  timer.start();

  fileLocs[0]="/Users/zhenzhen/Desktop/NMAexhibition_file_collection/project0";
  fileLocs[1]="/Users/zhenzhen/Desktop/NMAexhibition_file_collection/project1";
  fileLocs[2]="/Users/zhenzhen/Desktop/NMAexhibition_file_collection/project2";

  index = 0;
}

void draw() {
  if (timer.isFinished()) {
    println(fileLocs[index]);   
    try {
      Runtime.getRuntime().exec(cmd);
    }
    catch(Exception e) {
      println(e);
    }
    timer.start();
    if (index < fileLocs.length-1) {
      index++;
    } else {
      index = 0;
    }
  }
}