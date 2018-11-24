class Timer {

  private int savedTime = 999999999  ; // When Timer started
  private int totalTime;// How long Timer should last

  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  // Starting the timer
  void updateSavedTime() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
  }


  void updateTotalTime(int tempTotalTime) {
    totalTime = tempTotalTime;
    updateSavedTime();
  }

  int getTimeLeft() {
    return (int)((totalTime - (millis() - savedTime))/1000);
  }

  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis() - savedTime;
    //println("current time: " + millis() + ",  " + "savedTime" + savedTime + "  passedTime:  " + passedTime);
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
