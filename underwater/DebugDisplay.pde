class DebugDisplay {
  
  PFont localFont;
  GameObject gameObject;
  
  public DebugDisplay (GameObject target) {
    localFont = createFont("Calibri", 16, false);
    textFont(localFont);
    gameObject = target;
  }
  
  public void draw () {
    String posInfo = "Position (" + gameObject.position.x + ", " + gameObject.position.y + ")";
    text(posInfo, 5, 20);
  }
  
  public void printAvailableFonts () {
    String[] fonts = PFont.list();
    printArray(fonts);
  }
}