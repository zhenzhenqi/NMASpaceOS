import controlP5.*;


Timer timer;
int n = 5;

//cp5 elements
ControlP5 cp5;
ArrayList<Textarea> filePathTextAreas;
ArrayList<Button> chooseFileButtons;
ArrayList<RadioButton> fileTypeButtons;
ArrayList<Type> allTypes;

ButtonListener choosePathListener;
TypeListener chooseTypeListener;
Toggle runToggle;
color bgColor;
color runningBGColor = color(19, 103, 0);
color defaultBGColor = color(10);

Executable[] exes = new Executable[n];

//String[] filePaths = new String[n];

Textarea console;
String consoleContent = "";

int index;

boolean running;

//layout
int gPadding = 20;
int inputFieldH = 30;
int inputFieldW = 400;
int chooseFileBtnW = 100;
int padding = 20;

int consoleHeight = 100;

public enum Type {
  UNITY, PROCESSING, VIDEO
}

void setup() {
  size(900, 600);
  pixelDensity(2);
  cp5 = new ControlP5(this);

  filePathTextAreas = new ArrayList<Textarea>();
  chooseFileButtons = new ArrayList<Button>();
  fileTypeButtons = new ArrayList<RadioButton>();

  choosePathListener = new ButtonListener();
  chooseTypeListener = new TypeListener();

  for (int i=0; i < n; i++) {
    //exes
    exes[i] = new Executable();
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
    rb.setValue(-1);
    rb.addListener(chooseTypeListener);
    rb.setPosition(gPadding+inputFieldW+padding*2+chooseFileBtnW, (inputFieldH+padding) * i + gPadding);
    for (int i2 =0; i2<Type.values().length; i2++) {
      rb.addItem(Type.values()[i2] + "_" + i, i2);
    }
    fileTypeButtons.add(rb);
  }

  runToggle = cp5.addToggle("toggleRun")
    .setPosition(gPadding, (inputFieldH+padding) * n + gPadding)
    .setValue(false)
    .setSize(30, 30);

  cp5.addTextlabel("ConsoleLabel").setText("Console").setPosition(gPadding, height-consoleHeight-gPadding-20);
  console = cp5.addTextarea("console");
  console.setSize(width-gPadding*2, consoleHeight)
    .setColorBackground(30)
    .setLineHeight(10)
    .setPosition(gPadding, height-consoleHeight-gPadding);

  timer = new Timer(10000);//define a timer for 4 second long
  timer.start();
  index = 0;
}

void keyPressed() {
  if (key == 's') {
    running = true;
  }
}

void draw() {
  background(0);

  if (running) {
    Run();
    DrawRunningIndicator();
  }
}

void DrawRunningIndicator(){
  noStroke();
  fill(60, 255, 0);
  ellipse(width - gPadding, gPadding, 10, 10);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    String name = theEvent.getName();
    int groupID = Integer.parseInt(name.replaceAll("[\\D]", ""));
    exes[groupID].TYPE =  Type.values()[ (int)theEvent.getGroup().getValue() ];
  }
}

void execute(String path, boolean isProcessing) {
  if (isProcessing) {
    String sketchFolderPath =  path.substring(0, path.lastIndexOf('/')+1);
    try {
      Runtime.getRuntime().exec("/usr/local/bin/processing-java --sketch=" + sketchFolderPath + " --run");
    }
    catch(Exception e) {
      println(e);
    }
  } else {
    launch(path);
  }
}

void Run() {
  String processingOnlyTypeErrorMsg = ":    only work with processing yet.";
  String noTypeSetErrorMsg = ":    type hasn't been set.";
  String noPathErrorMsg = ":    file path isn't set.";
  if (timer.isFinished()) {
    timer.start();
    if (exes[index].TYPE!=null && exes[index].filepath != null) {
      switch(exes[index].TYPE) {
      case UNITY:
        //println(index + processingOnlyTypeErrorMsg);
        execute(exes[index].filepath, false);
        break;
      case PROCESSING:
        execute(exes[index].filepath, true);
        break;
      case VIDEO:
        //println(index + processingOnlyTypeErrorMsg);        
        execute(exes[index].filepath, false);
        break;
      default:
        println(index + noTypeSetErrorMsg);        
        break;
      }
    } else {
      if (exes[index].TYPE==null) {
        println(index + noTypeSetErrorMsg);
      }
      if (exes[index].filepath==null) {
        println(index + noPathErrorMsg);
      }
    }

    if (index < n - 1) {
      index++;
    } else {
      index = 0;
    }
  }
}

void toggleRun(boolean value) {
  if (value) {
    running = true;
    bgColor = runningBGColor;
  } else {
    running = false;
    bgColor = defaultBGColor;
  }
}

void log2console(String s) {
  consoleContent += s;
  console.setText(consoleContent);
}

class TypeListener implements ControlListener {
  public void controlEvent(ControlEvent theEvent) {
    println(theEvent.getController());
    println("!!!");
  }
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
      exes[id].filepath = filepath;
      println(filepath);
    } else {
      log2console("No file selected\n");
    }
  }
}