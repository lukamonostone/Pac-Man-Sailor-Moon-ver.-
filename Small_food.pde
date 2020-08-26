private class smallFood {
  private float smallFoodX, smallFoodY;
  // colors
  private int rStar, gStar, bStar;
  private int rPink, gPink, bPink;

  private smallFood(float FoodX, float FoodY) {
    smallFoodX = FoodX;
    smallFoodY = FoodY;
    smallFoodSizeX = width/rowNumber/1.5;
    smallFoodSizeY = height/rowNumber/1.5;
    smallFoodRadius = smallFoodSizeX/2;
    // colors
    rPink = 251; 
    gPink = 130;
    bPink = 173;
    rStar = 255;
    gStar = 220;
    bStar = 120;
  }

  private void display() {
    // draw small food - transformation brooch
    // basic pattern
    stroke(0);
    strokeWeight(1);
    fill(220, 170, 0);
    ellipse(smallFoodX, smallFoodY, smallFoodSizeX, smallFoodSizeY);
    fill(220, 170, 0);
    ellipse(smallFoodX, smallFoodY, smallFoodSizeX/1.4, smallFoodSizeY/1.4);
    // yellow moon
    stroke(0);
    strokeWeight(1);
    fill(rStar, gStar, bStar);
    ellipse(smallFoodX, smallFoodY, smallFoodSizeX/2, smallFoodSizeY/2);
    stroke(0);
    strokeWeight(0.5);
    fill(220, 170, 0);
    ellipse(smallFoodX, smallFoodY-height/rowNumber/20, smallFoodSizeX/2.5, smallFoodSizeY/3);
    // pink crystal
    fill(rPink, gPink, bPink);
    stroke(0);
    strokeWeight(1);
    ellipse(smallFoodX, smallFoodY-height/rowNumber/10, smallFoodSizeX/4, smallFoodSizeY/4);
    // small crystals
    fill(255, 0, 0);
    noStroke();
    ellipse(smallFoodX, smallFoodY-height/rowNumber/3.5, smallFoodSizeX/6, smallFoodSizeY/6);
    fill(33, 63, 255);
    ellipse(smallFoodX, smallFoodY+height/rowNumber/3.5, smallFoodSizeX/6, smallFoodSizeY/6);
    fill(10, 150, 0);
    ellipse(smallFoodX-width/rowNumber/3.5, smallFoodY, smallFoodSizeX/6, smallFoodSizeY/6);
    fill(255, 106, 0);
    ellipse(smallFoodX+width/rowNumber/3.5, smallFoodY, smallFoodSizeX/6, smallFoodSizeY/6);
  }
  
  private void eaten() {
    // condition for small food to become eaten by player
    if (playerRadius+smallFoodRadius > dist(playerX, playerY, smallFoodX, smallFoodY) && borderRepresentation[(int)smallFoodY/(width/rowNumber)][(int)(smallFoodX/(width/rowNumber))] == 1) {
      eaten = true;
      score = score+1;
      borderRepresentation[(int)(smallFoodY/(width/rowNumber))][(int)(smallFoodX/(width/rowNumber))] = 0;
      println("score:"+score);
    } else if (borderRepresentation[(int)smallFoodY/(width/rowNumber)][(int)(smallFoodX/(width/rowNumber))] == 1 && playerRadius+smallFoodRadius == dist(playerX, playerY, smallFoodX, smallFoodY)) {
      fill(0, 255, 0);
      ellipse(smallFoodX, smallFoodY, smallFoodSizeX, smallFoodSizeY);
    }
  }
}
