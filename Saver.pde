class Saver {
  PImage moon;
  PFont arcade;
  int moonX, moonY; 
  int rWords, gWords, bWords;
  float moonSizeX, moonSizeY;

  private Saver() {
    background(30);
    moon = loadImage("moon.png");
    moonX = width/2;
    moonY = height/2;
    moonSizeX = width/1.2; 
    moonSizeY = height/1.2;
    rWords = 255;
    gWords = 70;
    bWords = 120;
  }

  void display() {
    if (mouseClicks == 0) {
      imageMode(CENTER);
      image(moon, moonX, moonY, moonSizeX, moonSizeY);
      arcade = loadFont("Gabriola-60.vlw");
      textFont (arcade);
      textSize(48);
      textAlign(CENTER, CENTER);
      fill(rWords, gWords, bWords);
      text("Pacman (version Sailor Moon)", width/2, height/2);
      textSize(36);
      text("Press the mouse button", width/2, height/1.5);
    }
  }

  void mouse() {
    mouseClicks++;
  }
}
