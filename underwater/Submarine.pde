class Submarine extends GameObject {
  
  float localScale;
  PShape shape;
  
  Submarine (float s) {
    localScale = s;
    shape = createShape();
    shape.setStroke(false);
    shape.beginShape();
    shape.vertex(10, -10);
    shape.vertex(30, -10);
    shape.vertex(33, -7);
    shape.vertex(35, -5);
    shape.vertex(25, 5);
    shape.vertex(20, 7);
    shape.vertex(15, 10);
    shape.vertex(-50, 10);
    shape.vertex(-55, 7);
    shape.vertex(-57, 8);
    shape.vertex(-57, 9);
    shape.vertex(-65, 10);
    shape.vertex(-65, 3);
    shape.vertex(-70, 0);
    shape.vertex(-65, -3);
    shape.vertex(-65, -10);
    shape.vertex(-57, -9);
    shape.vertex(-57, -8);
    shape.vertex(-55, -7);
    shape.vertex(-50, -10);
    shape.vertex(-15, -10);
    shape.vertex(-5, -20);
    shape.vertex(10, -20);
    shape.endShape(CLOSE);
  }
  
  void draw () {
    pushMatrix();
    scale(localScale);
    shape(shape);
    popMatrix();
  }
}