class FishBand extends GameObject {
  
  static final int MAX_FISH = 200;
  static final float FISH_SPEED = 1.0;
  
  Fish fishPattern;
  
  float fishScale;
  PVector[] localPositions;
  float szBand;
  
  public FishBand (float popProbability, float scale) {
    fishPattern = new Fish(lerpColor(COLOR_SEA_LIGHT, COLOR_FISH, scale));
    fishScale = scale;
    
    int pop = int(Math.abs(randomGaussian()) * popProbability * MAX_FISH) + 3;
    localPositions = new PVector[pop]; //<>//
    int x, y;
    for (int i = 0; i < localPositions.length; i++) {
      x = -i*50;
      y = int(randomGaussian() * 100);
      localPositions[i] = new PVector(x, y);
    }
    szBand = localPositions[0].x - localPositions[localPositions.length-1].x;
  }
  
  void draw () {
    scale(fishScale);
    position.x += FISH_SPEED;
    if (position.x > width + szBand)
      position.x = 0.0;
    for (int i = 0; i < localPositions.length; i++) {
      pushMatrix();
      localPositions[i].y += randomGaussian();
      translate(localPositions[i].x, localPositions[i].y);
      fishPattern.draw();
      popMatrix();
    }
  }
}