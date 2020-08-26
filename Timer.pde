private class Timer {
  private float timeFrightened, timeEaten, timeBeggining, timeScatter;
  private float timeForScatter1, timeForScatter2, timeForChase;

  private Timer(float set) {
    timeScatter = set;
    timeFrightened = set;
    timeEaten = set;
    timeBeggining = set;
    timeForScatter1 = 7.0;
    timeForScatter2 = 5.0;
    timeForChase = 20.0;
  }

  private void countUp() {
    // timer for beggining (screen saver)
    timeBeggining = 1/frameRate;
    if (timeBeggining > 1) {
      beggining = false;
      timeBeggining = 0;
    } else {
      beggining = true;
    }

    // timer for scatter and chase mode
    if ( frightenedMode == 0 && win == false && lose == false) {
      timeScatter += 1/frameRate;
      if (timeScatter < timeForScatter1 || // 1st round of scatter (from 0 unitl 7 sec)
        (timeScatter > timeForScatter1+timeForChase && timeScatter < timeForChase+timeForScatter1*2) || // 2nd round of scatter (from 27 until 34 sec) 
        (timeScatter > timeForChase*2+timeForScatter1*2 && timeScatter < timeForChase*2+timeForScatter1*2+timeForScatter2) || // 3rd round of scatter (from 54 until 59 sec)
        (timeScatter > timeForChase*3+timeForScatter1*2+timeForScatter2 && timeScatter < timeForChase*3+timeForScatter1*2+timeForScatter2*2) // 4th round of scatter (from 79-84 sec)
        ) {
        scatterMode = 1;
        chaseMode = 0;
      } else {
        scatterMode = 0;
        chaseMode = 1;
      }
    }

    // timer for frightened mode
    if (frightenedMode == 1 && win == false) {
      timeFrightened += 1/frameRate;
      if (timeFrightened > 6.0) {
        frightenedMode = 0;
        timeFrightened = 0;
      }
    }
    // timer for eaten mode
    if (eaten == true) {
      timeEaten += 1/frameRate;
      if (timeEaten > 0.3) {
        eaten = false;
        timeEaten = 0;
      }
    }
  }
}
