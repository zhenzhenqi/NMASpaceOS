class Timer {

  int savedTime; // When Timer started
  int totalTime;// How long Timer should last

  Timer(int tempTotalTime) {
    savedTime = 99999999;
    totalTime = tempTotalTime;
  }

  // Starting the timer
  void updateSavedTime() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
  }


  void updateTotalTime(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    //println("current time: " + millis() + ",  " + "savedTime" + savedTime + "  passedTime:  " + passedTime);
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
