class Seaweed extends GameObject {
  
  float amplitude = 2.0;
  float frequency = TWO_PI/3.0;
  int baseHeight = 100;
  int baseWidth = 10;
  
  void draw () {
    fill(COLOR_SEAWEED);
    beginShape();
    
    float a = 0.0;
    int y = 10, x = 20;
    float sideX = -baseWidth/2;
    curveVertex(x, y);
    for (int i = 0; i < baseHeight; i+=10) {
      y = -i;
      x = int(sin(a) * amplitude + sideX);
      a += frequency;
      curveVertex(x, y);
    }
    y = -baseHeight-10;
    x = int(sideX);
    curveVertex(x, y);
    sideX += baseWidth;
    for (int i = baseHeight; i >= 0; i-= 10) {
      y = -i;
      x = int(sin(a) * amplitude + sideX);
      a += frequency;
      curveVertex(x, y);
    }
    y = 10;
    x = int(sideX);
    curveVertex(x, y);
    endShape(CLOSE);
  }
}