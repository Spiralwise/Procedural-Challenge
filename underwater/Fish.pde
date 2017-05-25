class Fish {
  
  PShape fishShape;
  
  public Fish (color fillColor) {
    
    fishShape = createShape(GROUP);

    PShape corpseShape = createShape();
    corpseShape.setStroke(false);
    corpseShape.setFill(fillColor);
    corpseShape.beginShape();
    corpseShape.vertex(50, 0); // NOSE
    corpseShape.vertex(20, 15);
    corpseShape.vertex(-10, 15);
    corpseShape.vertex(-80, 0); // TAIL BEGIN
    corpseShape.vertex(-120, -15);
    corpseShape.vertex(-110, 0);
    corpseShape.vertex(-120, 15);
    corpseShape.vertex(-80, 0); // TAIL END
    corpseShape.vertex(20, -15);
    corpseShape.endShape(CLOSE);
    
    PShape finBottom = createShape();
    finBottom.setStroke(false);
    finBottom.setFill(fillColor);
    finBottom.beginShape();
    finBottom.vertex(15, 15);
    finBottom.vertex(10, 25);
    finBottom.vertex(0, 25);
    finBottom.vertex(5, 15);
    finBottom.endShape(CLOSE);
    
    PShape finTop = createShape();
    finTop.setStroke(false);
    finTop.setFill(fillColor);
    finTop.beginShape();
    finTop.vertex(15, -15);
    finTop.vertex(10, -25);
    finTop.vertex(-30, -22);
    finTop.vertex(-27, -10);
    finTop.endShape(CLOSE);
    
    fishShape.addChild(corpseShape);
    fishShape.addChild(finBottom);
    fishShape.addChild(finTop);
  }
  
  void draw () {
    shape(fishShape);
  }
}