import controlP5.*;

ControlP5 cp5;
//http://www.dsfcode.com/using-processing-via-the-command-line/
//processing-java --sketch=[path] --run
Timer timer;
int n = 5;

//cp5 elements
ArrayList<Textarea> filePathTextAreas;
ArrayList<Button> chooseFileButtons;
ArrayList<RadioButton> fileTypeButtons;
ButtonListener choosePathListener;
String[] filePaths = new String[n];

Textarea console;
String consoleContent = "";

int index;


//layout
int gPadding = 20;
int inputFieldH = 30;
int inputFieldW = 400;
int chooseFileBtnW = 100;
int padding = 20;

int consoleHeight = 100;


void setup() {
  size(900, 600);
  pixelDensity(2);
  cp5 = new ControlP5(this);

  filePathTextAreas = new ArrayList<Textarea>();
  chooseFileButtons = new ArrayList<Button>();
  fileTypeButtons = new ArrayList<RadioButton>();
  filePaths = new String[n];

  choosePathListener = new ButtonListener();

  for (int i=0; i < n; i++) {
    //input field
    Textarea tl = cp5.addTextarea("filePath"+i);
    tl.setHeight(inputFieldH);
    tl.setWidth(inputFieldW);
    tl.enableColorBackground();
    tl.setColorBackground(color(30));
    tl.setPosition(gPadding, (inputFieldH+padding) * i + gPadding);
    filePathTextAreas.add(tl);
    //choose file buttons
    Button btn = cp5.addButton("chooseFilePath"+i);
    btn.setHeight(inputFieldH);
    btn.addListener(choosePathListener);
    btn.setPosition(gPadding+inputFieldW+padding, (inputFieldH+padding) * i + gPadding);
    btn.setLabel("Choose File Path");
    btn.setWidth(chooseFileBtnW);
    chooseFileButtons.add(btn);
    //radio buttons
    RadioButton rb = cp5.addRadioButton("fileType"+i);
    rb.setPosition(gPadding+inputFieldW+padding*2+chooseFileBtnW, (inputFieldH+padding) * i + gPadding);
    rb.addItem(i+"Unity", 1).addItem(i+"Processing", 2).addItem(i+"Video", 3);
    fileTypeButtons.add(rb);
  }

  cp5.addTextlabel("ConsoleLabel").setText("Console").setPosition(gPadding, height-consoleHeight-gPadding-20);
  console = cp5.addTextarea("console");
  console.setSize(width-gPadding*2, consoleHeight)
    .setColorBackground(30)
    .setLineHeight(10)
    .setPosition(gPadding, height-consoleHeight-gPadding);


  timer = new Timer(5000);//define a timer for 4 second long
  timer.start();
  index = 0;
}

void draw() {
  background(0);  
  //if (frameCount==100) {
  //  try {
  //    Runtime.getRuntime().exec("osascript -e 'quit app \"Preview\"'");
  //    println("quit");
  //  }
  //  catch(Exception e) {
  //    println(e);
  //  }
  //}
}
//void draw() {
//  if (timer.isFinished()) {

//    println(fileLocs[index]);   
//    try {
//      p = Runtime.getRuntime().exec(cmd);
//    }
//    catch(Exception e) {
//      println(e);
//    }
//    timer.start();
//    if (index < fileLocs.length-1) {
//      index++;
//    } else {
//      index = 0;
//    }
//  }
//}


void log2console(String s) {
  consoleContent += s;
  console.setText(consoleContent);
}

class ButtonListener implements ControlListener {
  public void controlEvent(ControlEvent theEvent) {
    Controller ctl = theEvent.getController();
    int id = -1;
    for (int i = 0; i < chooseFileButtons.size(); i++) {
      if (ctl == chooseFileButtons.get(i)) {
        id = i;
      }
    }
    java.awt.FileDialog dialog = new java.awt.FileDialog((java.awt.Frame)null, "Select the Executble file");
    dialog.setMode(java.awt.FileDialog.LOAD);
    dialog.setVisible(true);
    if (dialog.getFile()!=null && id != -1) {
      String filepath = dialog.getDirectory() + dialog.getFile();
      Textarea tf =  (Textarea)filePathTextAreas.get(id);
      tf.setText(filepath);
      filePaths[id] = filepath;
      println(filepath);
    } else {
      log2console("No file selected\n");
    }
  }
}