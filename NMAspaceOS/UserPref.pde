void loadSettings() {

  try {
    userpref = loadJSONObject(dataFileName);
  }
  catch(Exception e) {
    log2console("Cannot find saved data file :( \n");
    return;
  }

  //load paths
  JSONArray executables = userpref.getJSONArray("executables");

  if (executables != null) {
    for (int i=0; i<executables.size(); i++) {
      JSONObject executable = (JSONObject)executables.get(i);

      String filepath = executable.getString("path");
      
      String filetype = executable.getString("type");
      if (filetype!="") {
        //fileTypeButtons.get(i)
      }
    }
  } else {
    println("Didn't find any executable data in saved data.");
  }

  //interval
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
  userpref.setInt("interval", interval);

  //save all to json file
  saveJSONObject(userpref, dataFileName);
}