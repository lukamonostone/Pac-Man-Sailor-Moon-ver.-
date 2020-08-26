// Namgar Mardvaeva, 768094
// Pacman (Sailor Moon version)

private int [][] borderRepresentation = { // 8 - obstacles and borders, 7 - teleports, 1 - small food (transformation brooch), 3 - big food (Crimson Moon Compact)
  {8, 8, 8, 8, 8, 8, 7, 8, 8, 8, 8, 8, 8}, 
  {8, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 8}, 
  {8, 1, 8, 3, 1, 8, 8, 8, 1, 3, 8, 1, 8}, 
  {8, 1, 8, 8, 1, 1, 8, 1, 1, 8, 8, 1, 8}, 
  {8, 1, 8, 1, 1, 0, 3, 0, 1, 1, 8, 1, 8}, 
  {8, 1, 0, 1, 1, 8, 0, 8, 1, 1, 0, 1, 8}, 
  {7, 0, 8, 1, 1, 8, 8, 8, 1, 1, 8, 0, 7}, 
  {8, 1, 0, 1, 1, 1, 3, 1, 1, 1, 0, 1, 8}, 
  {8, 1, 8, 1, 1, 1, 8, 1, 1, 1, 8, 1, 8}, 
  {8, 1, 0, 1, 8, 1, 1, 1, 8, 1, 0, 1, 8}, 
  {8, 1, 8, 8, 8, 1, 8, 1, 8, 8, 8, 1, 8}, 
  {8, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 8}, 
  {8, 8, 8, 8, 8, 8, 7, 8, 8, 8, 8, 8, 8}, 
};
import processing.sound.*;
private SoundFile file;
private int rowNumber = 13;
private int cellSize;
private int sum;
private int score;
private int mouseClicks = 0;
float playerX, playerY, playerSize, playerRadius;
boolean win = false;
boolean lose = false;
boolean beggining = false;
boolean restart = true;
// classes
Saver screen;
Player p;
private Obstacles o;
private Enemies e;
private Timer t;
// food
private float smallFoodSizeX, smallFoodSizeY, smallFoodRadius;
private smallFood [][] sf = new smallFood[rowNumber][rowNumber];
private bigFood [][] bf = new bigFood[rowNumber][rowNumber];
// enemies modes
private boolean eaten = false; 
private int chaseMode;
private int frightenedMode = 0;
private int scatterMode;



void setup() {
  size(650, 650);
  cellSize = width/rowNumber;
  if (mouseClicks == 0) {
    file = new SoundFile(this, "sailormoon.wav");
    file.play();
  }
  screen = new Saver();
  t = new Timer(0);
  for (int i = 1; i < rowNumber; i++)
    for (int j = 1; j < rowNumber; j++)
      switch(borderRepresentation[i][j]) {
      case 1: 
        sf[i][j] = new smallFood(width/rowNumber*(j+0.5), height/rowNumber*(i+0.5));
        sum += borderRepresentation[i][j];
        score = 0;
        break;
      case 3:
        bf[i][j] = new bigFood(width/rowNumber*(j+0.5), height/rowNumber*(i+0.5));
        sum += borderRepresentation[i][j];
        score = 0;
        if (borderRepresentation[i][j] == 10) {
        }
        break;
      case 8:
        o = new Obstacles();
        break;
      }
  e = new Enemies();
  p = new Player();
}

void draw() {
  screen.display();
  if (mouseClicks >= 1) {
    background(30);
    for (int i = 0; i < rowNumber; i++) { // functions for obstacles
      for (int j = 0; j < rowNumber; j++) {
        if (borderRepresentation[i][j] == 8) {
          o.star(j*width/rowNumber+width/rowNumber/2, i*height/rowNumber+height/rowNumber/2);
        }
      }
    }
    for (int i = 0; i < rowNumber; i++) { // functions for food
      for (int j = 0; j < rowNumber; j++) {
        if (borderRepresentation[i][j] == 1) {
          sf[i][j].display();
          sf[i][j].eaten();
          //sf[i][j].winningCase();
        } else if (borderRepresentation[i][j] == 3) {
          bf[i][j].display();
          bf[i][j].eaten();
          //bf[i][j].winningCase();
        }
      }
    } 
    e.display(); // functions for enemies
    e.distance();
    e.checkBorder();
    e.move();
    // enemy's modes
    e.scatter();
    e.chase();
    e.frightened();
    p.display(); // functions for player
    p.move();
    p.teleport();
    p.winningCase();
    p.losingCase();
    t.countUp();
  }
}


void mousePressed() {
  screen.mouse();
}
