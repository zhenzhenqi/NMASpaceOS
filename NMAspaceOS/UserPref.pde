void loadSettings() {
  //load file
  try {
    userpref = loadJSONObject(dataFileName);
  }
  catch(Exception e) {
    log2console("Cannot find saved data file \n");
    return;
  }
  log2console("Found JSON file Successfully\n");

  //load paths
  JSONArray executables = userpref.getJSONArray("executables");

  if (executables != null) {
    if (executables.size()!=n) {
      log2console("Number of projects in saved settings doesn't match the current number of projects, loading aborting...");
      return;
    }
    for (int i=0; i<executables.size(); i++) {
      JSONObject executable = (JSONObject)executables.get(i);

      String filepath = executable.getString("path");
      Textarea ta = filePathTextAreas.get(i);

      if (filepath != null) {
        ta.setText(filepath);
        exes[i].filepath = filepath;
        println("set " + i + " exe's filepath to: " + filepath);
      } else {
        println("["+i+"] filepath is null");
      }

      String filetype = executable.getString("type");
      if (filetype != "" && filetype.length() > 1) {
        println("["+i+"]  Loading types: " + filetype);
        try {
          exes[i].TYPE = Type.valueOf(filetype);
          int typeIndex = Type.valueOf(filetype).ordinal();
          RadioButton rb = fileTypeButtons.get(i);
          rb.activate(typeIndex);
        }
        catch(Exception e) {
          println(e);
          println("failed to load type into GUI");
        }
      } else {
        println("["+i+"]:  type invalid");
      }
      println("----------------------------");
    }
  } else {
    println("Didn't find any executable data in saved data.");
  }

  //interval
  int _interval = -1;
  try {
    _interval = userpref.getInt("interval");
    if (_interval != -1) {
      println("interval loaded.");
      intervalValue = _interval;
      intervalSlider.setValue(intervalValue);
    }
  }
  catch(Exception e) {
    log2console(e+"\n");
  }
  if (userpref.hasKey("interval")) {
    println("interval value: "+userpref.getInt("interval"));
    intervalValue = userpref.getInt("interval");
  }
}


void saveSettings() {
  println("saving...");
  userpref = new JSONObject();
  //save exe path and type
  JSONArray executables = new JSONArray();
  for (int i=0; i < filePathTextAreas.size(); i++) {
    JSONObject executable = new JSONObject();
    executable.setString("path", exes[i].filepath);
    if (exes[i].TYPE != null) {
      executable.setString("type", exes[i].TYPE.name());
    } else {
      executable.setString("type", "");
    }
    //save [executable] to [executables]
    executables.setJSONObject(i, executable);
  }
  userpref.setJSONArray("executables", executables);

  //save interval
  userpref.setInt("interval", intervalValue);

  //save all to json file
  saveJSONObject(userpref, dataFileName);
}
