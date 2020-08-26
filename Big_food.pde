private class bigFood {
  private float bigFoodX, bigFoodY, bigFoodSizeX, bigFoodSizeY, bigFoodRadius;
  private PImage bigFood;

  private bigFood(float FoodX, float FoodY) {
    bigFood = loadImage("CrimsonMoonCompact.png");
    bigFoodX = FoodX;
    bigFoodY = FoodY; 
    bigFoodSizeX = smallFoodSizeX*2; 
    bigFoodSizeY = smallFoodSizeY*2;
    bigFoodRadius = bigFoodSizeX/2;
  }
  private void display() {
    // draw big food
    imageMode(CENTER);
    image(bigFood, bigFoodX, bigFoodY, bigFoodSizeX, bigFoodSizeY);
  }

  private void eaten() {
    // condition for big food to become eaten by player
    if (playerRadius+bigFoodRadius > dist(playerX, playerY, bigFoodX, bigFoodY) /*&& borderRepresentation[(int)bigFoodY/(width/rowNumber)][(int)(bigFoodX/(width/rowNumber))] == 3*/) {
      frightenedMode = 1;
      eaten = true;
      score = score+3;
      borderRepresentation[(int)(bigFoodY/(width/rowNumber))][(int)(bigFoodX/(width/rowNumber))] = 10;
    } else if (borderRepresentation[(int)bigFoodY/(width/rowNumber)][(int)(bigFoodX/(width/rowNumber))] == 1 && playerRadius+bigFoodRadius == dist(playerX, playerY, bigFoodX, bigFoodY)) {
      fill(0, 255, 0);
      ellipse(bigFoodX, bigFoodY, bigFoodSizeX, bigFoodSizeY);
    }
  }
}
