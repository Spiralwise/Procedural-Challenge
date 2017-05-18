Layer[] layers;

void setup () {
  size(445, 720);
    
  JSONObject config = loadJSONObject("config.json");
  JSONObject dataFrames = config.getJSONObject("frames");
  JSONArray dataFrameHeights = dataFrames.getJSONArray("height");
  JSONArray dataFrameVariations = dataFrames.getJSONArray("variation");
  JSONArray dataFrameSpacings = dataFrames.getJSONArray("spacing");
  JSONArray dataFrameBrightnesses = dataFrames.getJSONArray("brightness");
  // TODO : Instead of spacing + brightness, have a distance and computes spacing + brightness from distance
  
  int frameCount = dataFrameHeights.size();
  layers = new Layer[frameCount];
  for (int i = 0; i < frameCount; i++)
    layers[i] = new Layer(dataFrameHeights.getFloat(i)
      , dataFrameVariations.getInt(i)
      , dataFrameSpacings.getInt(i)
      , dataFrameBrightnesses.getFloat(i));
}

void draw () {
  drawBackground();
  for (int i = layers.length-1; i >= 0; i--)
    layers[i].draw();
}

void drawBackground () {
  color lineColor;
  float heightRatio;
  for (int y = 0; y < height; y++) {
    heightRatio = ((float)y)/height;
    lineColor = lerpColor(COLOR_SEA_LIGHT, COLOR_SEA_DARK, heightRatio);
    stroke(lineColor);
    line(0, y, width, y);
  }
}