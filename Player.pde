class Player {
  private float speed;
  private float getXpos, getYpos;
  private float checkCornersOfPlayerLeft, checkCornersOfPlayerRight, checkCornersOfPlayerUp, checkCornersOfPlayerDown;
  private int rWords, gWords, bWords;
  private PFont arcade;

  Player() {
    playerX = width/rowNumber*6.5;
    playerY = height/rowNumber*11.5;
    playerSize = width/30;
    playerRadius = playerSize/2;
    checkCornersOfPlayerLeft = 0.4;
    checkCornersOfPlayerRight = 0.4;
    checkCornersOfPlayerUp = 0.4;
    checkCornersOfPlayerDown = 0.4;
    speed = 3;
    // colors
    rWords = 247; 
    gWords = 213; 
    bWords = 89;
    // coefficients for drawing cat - Moon
  }
  // draw player
  private void display() {
    getXpos = playerX/cellSize;
    getYpos = playerY/cellSize;

    // player's shape (cat - Moon)
    //ears
    stroke(0);
    strokeWeight(1);
    fill(40, 40, 70);
    triangle(playerX-width*0.035, playerY, playerX-width*0.035, playerY-height*0.05, playerX+width*0.01, playerY-height*0.03);
    triangle(playerX+width*0.035, playerY, playerX+width*0.035, playerY-height*0.05, playerX-width*0.01, playerY-height*0.03);
    fill(251, 130, 173);
    triangle(playerX-width*0.035, playerY, playerX-width*0.035, playerY-height*0.045, playerX+width*0.01, playerY-height*0.02);
    triangle(playerX+width*0.035, playerY, playerX+width*0.035, playerY-height*0.045, playerX-width*0.01, playerY-height*0.02);
    // face
    noStroke();
    fill(40, 40, 70);
    ellipse(playerX, playerY, width/rowNumber/1.1, height/rowNumber);
    ellipse(playerX, playerY+height*0.02, width/rowNumber, height/rowNumber/1.4);
    // face expressions
    // eyes
    fill(255);
    ellipse(playerX+width*0.015, playerY, width/rowNumber/4, height/rowNumber/3);
    ellipse(playerX-width*0.015, playerY, width/rowNumber/4, height/rowNumber/3);
    fill(150, 50, 0, 200);
    ellipse(playerX+width*0.012, playerY, width/rowNumber/5, height/rowNumber/4);
    ellipse(playerX-width*0.012, playerY, width/rowNumber/5, height/rowNumber/4);
    fill(255);
    ellipse(playerX+width*0.014, playerY, width/rowNumber/10, height/rowNumber/8);
    ellipse(playerX-width*0.014, playerY, width/rowNumber/10, height/rowNumber/8);
    // moon
    fill(255, 255, 0);
    ellipse(playerX, playerY-height*0.025, width/rowNumber/4, height/rowNumber/4);
    fill(40, 40, 70);
    ellipse(playerX, playerY-height*0.029, width/rowNumber/5, height/rowNumber/5.5);
    // mustache
    stroke(40, 40, 70);
    strokeWeight(2);
    line(playerX, playerY+height*0.02, playerX-width*0.05, playerY+height*0.025);
    line(playerX, playerY+height*0.02, playerX-width*0.05, playerY+height*0.015);
    line(playerX, playerY+height*0.02, playerX+width*0.05, playerY+height*0.025);
    line(playerX, playerY+height*0.02, playerX+width*0.05, playerY+height*0.015);
    // mouth
    if (eaten == true) {
      fill(251, 130, 173);
      stroke(0);
      strokeWeight(0.6);
      triangle(playerX-width*0.01, playerY+height*0.02, playerX+width*0.01, playerY+height*0.02, playerX, playerY+height*0.04);
    }
  }

  // assignment of key for moving player
  void move() {
    if (win == false && lose == false) {
      switch(key) {
      case 'a': 
      case 'A': 
        if (borderRepresentation[int(getYpos)][int(getXpos-checkCornersOfPlayerLeft)] != 8) { // moving left
          playerX-=speed;
        }
        break;
      case 'd': // moving right
      case 'D':
        if (borderRepresentation[int(getYpos)][int(getXpos+checkCornersOfPlayerRight)] != 8) { // moving right
          playerX+=speed;
        } 
        break;
      case 's': // moving down
      case 'S':
        if (borderRepresentation[int(getYpos+checkCornersOfPlayerDown)][int(getXpos)] != 8) { // moving down
          playerY += speed;
        } 
        break;
      case 'w': // moving up 
      case 'W':
        if (borderRepresentation[int(getYpos-checkCornersOfPlayerUp)][int(getXpos)] != 8) { // moving up
          playerY -= speed;
        } 
        break;
      }
    }
  }

  // teleport player, if he is near holes
  void teleport() {
    if (win == false && lose == false) {
      switch(key) {
      case 'a': 
      case 'A': 
        if (borderRepresentation[int(getYpos)][int(getXpos-checkCornersOfPlayerRight)] == 7) { // teleport to right, if player in hole
          playerX = width-cellSize;
        }
        break;
      case 'd': // moving right
      case 'D':
        if (borderRepresentation[int(getYpos)][int(getXpos+checkCornersOfPlayerLeft)] == 7) { // teleport to left, if player in hole
          playerX = cellSize;
        } 
        break;
      case 's': // moving down
      case 'S':
        if (borderRepresentation[int(getYpos+checkCornersOfPlayerUp)][int(getXpos)] == 7) { // teleport to ceiling, if player in hole
          playerY = cellSize;
        }
        break;
      case 'w': // moving up 
      case 'W':
        if (borderRepresentation[int(getYpos-checkCornersOfPlayerDown)][int(getXpos)] == 7) { // teleport to floor, if player in hole
          playerY = height-cellSize;
        }

        break;
      }
    } else {
    }
  }
  void winningCase() {
    if (score == sum) {
      stroke(rWords, gWords, bWords);
      strokeWeight(3);
      fill(20);
      rectMode(CENTER);
      rect(width/2, height/2, width/2.5, height/9, width/rowNumber);
      arcade = loadFont("Gabriola-60.vlw");
      textFont (arcade);
      textSize(48);
      textAlign(CENTER, CENTER);
      fill(rWords, gWords, bWords);
      text("YOU WON", width/2, height/2);
      win = true;
    }
  }
  void losingCase() {
    if (lose == true) {
      stroke(rWords, gWords, bWords);
      strokeWeight(3);
      fill(20);
      rectMode(CENTER);
      rect(width/2, height/2, width/2.5, height/9, width/rowNumber);
      arcade = loadFont("Gabriola-60.vlw");
      textFont (arcade);
      textSize(48);
      textAlign(CENTER, CENTER);
      fill(rWords, gWords, bWords);
      text("YOU LOST", width/2, height/2);
    }
  }
}
