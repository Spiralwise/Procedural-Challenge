class FishBand extends GameObject {
  
  static final int MAX_FISH = 200;
  
  Fish fishPattern;
  
  float fishScale;
  PVector[] localPositions;
  
  public FishBand (float popProbability, float scale) {
    fishPattern = new Fish(lerpColor(COLOR_SEA_LIGHT, COLOR_FISH, scale));
    fishScale = scale;
    
    int pop = int(Math.abs(randomGaussian()) * popProbability * MAX_FISH); //<>//
    localPositions = new PVector[pop];
    int x, y;
    for (int i = 0; i < localPositions.length; i++) {
      x = -i*50;
      y = int(randomGaussian() * 100);
      localPositions[i] = new PVector(x, y);
    }
  }
  
  void draw () {
    translate(100, 100);
    scale(fishScale);
    for (int i = 0; i < localPositions.length; i++) {
      pushMatrix();
      translate(localPositions[i].x, localPositions[i].y);
      fishPattern.draw();
      popMatrix();
    }
  }
}