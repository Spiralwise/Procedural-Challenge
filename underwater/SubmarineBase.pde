class SubmarineBase extends GameObject {
  
  final int bevel = 5;
  final int floorHeight = 13;
  final int windowHeight = 6;
  final int windowHeightBase = 3;
  final int windowCounts = 4;
  final int windowMargin = 10;
  
  int floors;
  int baseWidth;
  
  SubmarineBase (int f, int bw) {
    floors = f;
    baseWidth = bw;
  }
  
  void draw () {
    int demiWidth = baseWidth/2;
    noStroke();
    fill(COLOR_SUBBASE);
    rect(-demiWidth + bevel, 0, baseWidth - 2 * bevel, 20);
    fill(COLOR_SUBBASE_SHADOW);
    quad(-demiWidth + bevel, 0, -demiWidth, -bevel, demiWidth, -bevel, demiWidth - bevel, 0);
    pushMatrix();
    translate(0, -bevel);
    fill(COLOR_SUBBASE);
    rect(-demiWidth, 0, baseWidth, -floors * floorHeight);
    translate(-demiWidth, -windowHeightBase);
    fill(COLOR_SUBBASE_GLASS_SHADOW);
    int windowWidth = (baseWidth - windowCounts * windowMargin) / windowCounts; 
    for (int f = 0; f < floors; f++) {
      pushMatrix();
      translate(windowMargin/2, 0);
      for (int w = 0; w < windowCounts; w++) {
        rect(0, 0, windowWidth, -windowHeight);
        translate(windowWidth + windowMargin, 0);
      }
      popMatrix();
      translate(0, -floorHeight);
    }
    fill(COLOR_SUBBASE_GLASS);
    translate(demiWidth, windowHeightBase);
    rotate(PI);
    arc(0, 0, baseWidth, baseWidth/3, 0, PI);
    rotate(PI);
    translate(demiWidth/2, -baseWidth/12);
    fill(#FFFFFF);
    ellipse(0, 0, baseWidth/6, baseWidth/18);
    popMatrix();
  }
}