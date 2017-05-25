abstract class GameObject {
  
  PVector position;
  
  public GameObject () {
    position = new PVector();
  }
  
  public void setPosition (int x, int y) {
    position.x = x;
    position.y = y;
  }
  
  public void setRandomPosition () {
    position.x = int(random(width));
    position.y = int(random(height));
  }
  
  public PVector getPosition () {
    return position;
  }
  
  public abstract void draw ();
}