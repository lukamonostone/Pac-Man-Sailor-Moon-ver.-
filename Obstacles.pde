private class Obstacles {
  private int rStar, gStar, bStar;

  private Obstacles() {
    rStar = 247;
    gStar = 213;
    bStar = 89;
  }

  private void star(int j, int i) {
    fill(0, 0);
    stroke(rStar, gStar, bStar);
    strokeWeight(2);
    beginShape();
    vertex(0+j, -height/rowNumber/3.8+i);
    vertex(width/rowNumber/14+j, -height/rowNumber/10+i);
    vertex(width/rowNumber/4+j, -height/rowNumber/13+i);
    vertex(width/rowNumber/8.7+j, height/rowNumber/28+i);
    vertex(width/rowNumber/6.9+j, height/rowNumber/5+i);
    vertex(0+j, height/rowNumber/8+i);
    vertex(-width/rowNumber/6.9+j, height/rowNumber/5+i);
    vertex(-width/rowNumber/8.7+j, height/rowNumber/28+i);
    vertex(-width/rowNumber/4+j, -height/rowNumber/13+i);
    vertex(-width/rowNumber/14+j, -height/rowNumber/10+i);
    endShape(CLOSE);
  }
}
