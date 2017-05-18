class Layer {

  ArrayList<Integer> ground_starts;
  int spacing;
  float brightness;

  public Layer (float ground_height, int variation, int edge_width, float bright) {
    ground_starts = new ArrayList<Integer>();
    spacing = edge_width;
    brightness = bright;
    
    int current_height = int(height*(1.0 - ground_height));
    int ground_max_width = width * 3;
    for (int i = 0; i < ground_max_width; i+=spacing) {
      ground_starts.add(current_height);
      current_height += variation * random(-0.5, 0.5);
    }
  }
  
  public void draw () {
    noStroke();
    fill(lerpColor(COLOR_BLACK, COLOR_SEABED, brightness));
    beginShape();
    for (int i = 0; i < ground_starts.size(); i++) {
      vertex(i*spacing, ground_starts.get(i));
    }
    vertex(width, height);
    vertex(0, height);
    endShape();
  }
}