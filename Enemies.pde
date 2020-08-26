private class Enemies {
  private float enemiesX, enemiesY;
  private int enemiesSizeX, enemiesSizeY;
  private float upY, downY, leftX, rightX;
  private int enemiesSpeed;
  private float distanceUp, distanceDown, distanceLeft, distanceRight, currentDistance;
  private float checkCornersOfEnemies;
  private int border;
  private int r, g, b;
  private float scatterX1, scatterY1;

  private Enemies() {
    // assign value to loaction of scatterMode
    scatterX1 = width/rowNumber*4.5;
    scatterY1 = height/rowNumber*1.5;
    // enemies characteristics
    enemiesSizeX = width/20;
    enemiesSizeY = height/20;
    enemiesX = width/rowNumber*6.5;
    enemiesY = height/rowNumber*5.5;
    enemiesSpeed = 2;
    checkCornersOfEnemies = 0.7;
    border = 800;
    r = 180;
    g = 0;
    b = 0;
  }

  private void display() {
    fill(0);
    stroke(r, g, b);
    strokeWeight(2);
    ellipse(enemiesX, enemiesY, enemiesSizeX, enemiesSizeY);
    fill(0);
    // dark moon
    arc(enemiesX, enemiesY, enemiesSizeX*0.5, enemiesSizeY*0.5, 5*PI/6, PI*13/6, OPEN);
    arc(enemiesX, enemiesY+height/rowNumber/10, enemiesSizeX*0.35, enemiesSizeY*0.5, PI, PI*2, OPEN);
  }

  private void distance() {
    // computing possible location of enemy
    leftX = enemiesX-enemiesSpeed;
    rightX = enemiesX+enemiesSpeed;
    upY = enemiesY-enemiesSpeed;
    downY = enemiesY+enemiesSpeed;
    currentDistance = dist(playerX, playerY, enemiesX, enemiesY);
  }
  void scatter() {
    // computing distance between possible location of enemy and place for scattering
    if (scatterMode == 1) {
      distanceLeft = dist(scatterX1, scatterY1, leftX, enemiesY);
      distanceRight = dist(scatterX1, scatterY1, rightX, enemiesY);
      distanceUp = dist(scatterX1, scatterY1, enemiesX, upY);
      distanceDown = dist(scatterX1, scatterY1, enemiesX, downY);
    }
  }

  void chase() {
    // computing distance between possible location of enemy and player
    if (chaseMode == 1 || frightenedMode == 1) {
      distanceLeft = dist(playerX, playerY, leftX, enemiesY);
      distanceRight = dist(playerX, playerY, rightX, enemiesY);
      distanceUp = dist(playerX, playerY, enemiesX, upY);
      distanceDown = dist(playerX, playerY, enemiesX, downY);
    }
  }

  private void checkBorder() {
    // checking, if there are borders in possible location (down, up, left, right)
    if (borderRepresentation[int(downY/cellSize+checkCornersOfEnemies)][int(enemiesX/cellSize)] == 8) { // down
      if (frightenedMode == 0) 
        distanceDown = border;
      else
        distanceDown = - border;
    }
    if (borderRepresentation[int(upY/cellSize-checkCornersOfEnemies)][int(enemiesX/cellSize)] == 8) { // up
      // assignment of wrong distance for step up, if there are border
      if (frightenedMode == 0) 
        distanceUp = border;
      else 
      distanceUp = - border;
    }
    if (borderRepresentation[int(enemiesY/cellSize)][int(leftX/cellSize-checkCornersOfEnemies)] == 8) { // left
      // assignment of wrong distance for step left, if there are border
      if (frightenedMode == 0) 
        distanceLeft = border;
      else
        distanceLeft = -border;
    }
    if (borderRepresentation[int(enemiesY/cellSize)][int(rightX/cellSize+checkCornersOfEnemies)] == 8) { // right
      // assignment of wrong distance for step right, if there are border
      if (frightenedMode == 0) 
        distanceRight = border;
      else
        distanceRight = -border;
    }
  }

  private void move() {
    // enemy's movement
    if (win == false && frightenedMode != 1) {
      if ((playerSize+enemiesSizeX)/2 < currentDistance) {
        // down
        if (distanceDown < distanceUp && distanceDown < distanceLeft && distanceDown < distanceRight) {
          enemiesY = downY;
        } else if (distanceUp < distanceDown && distanceUp < distanceLeft && distanceUp < distanceRight) {
          // up
          enemiesY = upY;
        } else if (distanceLeft < distanceDown && distanceLeft < distanceUp && distanceLeft < distanceRight) {
          // left
          enemiesX = leftX;
        } else if (distanceRight < distanceDown && distanceRight < distanceUp && distanceRight < distanceLeft) {
          // right
          enemiesX = rightX;
        } else if (distanceLeft == distanceRight || distanceLeft == distanceDown || distanceLeft == distanceUp) {
          enemiesX = leftX;
        } else if (distanceRight == distanceDown || distanceRight == distanceUp) {
          enemiesX = rightX;
        } else if (distanceDown == distanceUp) {
          enemiesY = upY;
        }
      } else {
        lose = true;
        
      }
    }
  }

  void frightened() {
    if (frightenedMode == 1 && win == false) {
      lose = false;
      r = 0;
      b = 200;
      // checking borders
      if (borderRepresentation[int(downY/cellSize+checkCornersOfEnemies)][int(enemiesX/cellSize)] == 8) { // down
        distanceDown = - border;
      }
      if (borderRepresentation[int(upY/cellSize-checkCornersOfEnemies)][int(enemiesX/cellSize)] == 8) { // up
        // assignment of wrong distance for step up, if there are border
        distanceUp = - border;
      }
      if (borderRepresentation[int(enemiesY/cellSize)][int(leftX/cellSize-checkCornersOfEnemies)] == 8) { // left
        // assignment of wrong distance for step left, if there are border
        distanceLeft = -border;
      }
      if (borderRepresentation[int(enemiesY/cellSize)][int(rightX/cellSize+checkCornersOfEnemies)] == 8) { // right
        // assignment of wrong distance for step right, if there are border
        distanceRight = -border;
      }

      // enemies in frightened mode move in opposite direction from player
      if ((playerSize+enemiesSizeX)/2 < currentDistance) {
        // down
        if (distanceDown > distanceUp && distanceDown > distanceLeft && distanceDown > distanceRight) {
          enemiesY = downY;
        } else if (distanceUp > distanceDown && distanceUp > distanceLeft && distanceUp > distanceRight) {
          // up
          enemiesY = upY;
        } else if (distanceLeft > distanceDown && distanceLeft > distanceUp && distanceLeft > distanceRight) {
          // left
          enemiesX = leftX;
        } else if (distanceRight > distanceDown && distanceRight > distanceUp && distanceRight > distanceLeft) {
          // right
          enemiesX = rightX;
        } else if (distanceLeft == distanceRight || distanceLeft == distanceDown || distanceLeft == distanceUp) {
          enemiesX = leftX;
        } else if (distanceRight == distanceDown || distanceRight == distanceUp) {
          enemiesX = rightX;
        } else if (distanceDown == distanceUp) {
          enemiesY = upY;
        }
      } else {
        // resetting position of an enemy, if player eats an enemy in frightened mode
        enemiesX = width/rowNumber*6.5;
        enemiesY = height/rowNumber*5.5;
        frightenedMode = 0;
      }
    } else {
      // ending of frightened mode that depends from (class) Timer 
      frightenedMode = 0;
      r = 150;
      b = 0;
    }
  }
}
