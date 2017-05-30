class Layer {
  
  static final int MIN_SPACING = 5;
  static final int RATIO_SPACING_DISTANCE = 10; 

  float distance; 
  color lightColor, lightTransparentColor;
  float raylightDepth;
  float raylightSlope;

  int spacing;
  float blendingRatio;
  PShape groundShape;
  ArrayList<Integer> groundHeights;
  ArrayList<Integer> raylightPositions;
  ArrayList<Integer> raylightWidth;
  ArrayList<GameObject> gameObjects;

  public Layer (JSONObject settings) {
    groundHeights = new ArrayList<Integer>();
    distance = settings.getFloat("distance");
    spacing = int(distance * RATIO_SPACING_DISTANCE) + MIN_SPACING;
    
    blendingRatio = Math.min(distance, 1.0);
    
    gameObjects = new ArrayList<GameObject>();
    
    int variation = settings.getInt("variation");
    int current_height = int(height*(1.0 - settings.getFloat("height")));
    int ground_max_width = width * 3;
    for (int i = 0; i < ground_max_width; i+=spacing) {
      groundHeights.add(current_height);
      current_height += variation * random(-0.5, 0.5);
    }
    
    groundShape = createShape();
    groundShape.setStroke(false);
    groundShape.setFill(lerpColor(COLOR_SEABED, COLOR_SEA_LIGHT, blendingRatio));
    groundShape.beginShape();
    for (int i = 0; i < groundHeights.size(); i++) {
      groundShape.vertex(i*spacing, groundHeights.get(i));
    }
    groundShape.vertex(width, height);
    groundShape.vertex(0, height);
    groundShape.endShape(CLOSE);

    setFishBand(settings.getFloat("fish_density"));
    if (!settings.isNull("subbase"))
      setSubmarineBase(settings.getJSONObject("subbase"));
  }
  
  public void draw () {
    drawGameObjects();
    shape(groundShape);
    drawRaylights();
  }
  
  void drawRaylights () {
    if (raylightPositions == null && raylightWidth == null)
      return;
    for (int i = 0; i < raylightPositions.size(); i++) {
      int depthCount = int(height * raylightDepth);
      int currentRayWidth = raylightWidth.get(i);
      int currentRayPos = raylightPositions.get(i);
      float slopeRemainder = 0.0;
      for (int y = 0; y < depthCount; y++) {
        float t = float(y)/depthCount;
        stroke(lerpColor(lightColor, lightTransparentColor, t));
        line(currentRayPos, y, currentRayPos + currentRayWidth, y);
        slopeRemainder += raylightSlope;
        if (slopeRemainder >= 1.0) {
          slopeRemainder -= 1.0;
          currentRayPos--;
        }
      }
    }
  }
  
  void drawGameObjects () {
    PVector position;
    for (int i = 0; i < gameObjects.size(); i++) {
      pushMatrix();
      position = gameObjects.get(i).getPosition();
      translate(position.x, position.y);
      gameObjects.get(i).draw();
      popMatrix();
    }
  }
  
  public void setLight (JSONObject lightSettings) {
    JSONObject numberVariation = lightSettings.getJSONObject("number");
    int nb = int(random(numberVariation.getInt("min"), numberVariation.getInt("max")+1));
    JSONObject widthVariation = lightSettings.getJSONObject("width");
    
    raylightPositions = new ArrayList<Integer>();
    raylightWidth = new ArrayList<Integer>();
    int minRange = 0, maxRange = width/nb;
    for (int i = 0; i < nb; i++) {
      int position = int(random(minRange, maxRange));
      raylightPositions.add(position);
      int rayWidth = int(random(widthVariation.getInt("min"), widthVariation.getInt("max")));
      raylightWidth.add(rayWidth);
      minRange = position + rayWidth;
      maxRange = minRange + width/nb;
    }
    
    JSONArray colorComponents = lightSettings.getJSONArray("color");
    lightColor = color(colorComponents.getInt(0), colorComponents.getInt(1), colorComponents.getInt(2), colorComponents.getInt(3));
    lightTransparentColor = (lightColor & 0xffffff);
    raylightDepth = lightSettings.getFloat("depth");
    raylightSlope = lightSettings.getFloat("slope");
  }
  
  void setSubmarineBase (JSONObject settings) {
    int x = groundHeights.size() / 6;
    int y = groundHeights.get(x);
    x *= spacing;
    JSONObject floorsParams = settings.getJSONObject("floor");
    JSONObject widthParams = settings.getJSONObject("width");
    int floors = int(random(floorsParams.getInt("min"), floorsParams.getInt("max") - floorsParams.getInt("min") + 1));
    int baseWidth = int(random(widthParams.getInt("min"), widthParams.getInt("max")));
    GameObject submarineBase = new SubmarineBase(floors, baseWidth);
    submarineBase.setPosition(x, y);
    gameObjects.add(submarineBase);
  }
  
  void setFishBand (float fishDensity) {
    float probability = Math.min(fishDensity, 0.9);
    float x = -distance + 1;
    float scale = (x * x * x) / 2;
    float dice;
    do {
      FishBand band = new FishBand(fishDensity, scale);
      band.setRandomPosition();
      gameObjects.add(band);
      dice = random(1.0);
    } while (dice < probability);
  }
}