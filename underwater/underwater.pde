Layer[] layers;
DebugDisplay dd;

/*Seaweed testSeaweed;
Submarine testSub;*/

void setup () {
  size(445, 720);
    
  JSONObject config = loadJSONObject("config.json");
  JSONArray dataLayers = config.getJSONArray("layers");
  JSONObject dataLights = config.getJSONObject("raylight");
  
  int frameCount = dataLayers.size();
  layers = new Layer[frameCount];
  for (int i = 0; i < frameCount; i++) {
    layers[i] = new Layer(dataLayers.getJSONObject(i));
    layers[i].setLight(dataLights);
  }
  dd = new DebugDisplay(layers[0].gameObjects.get(0));
   /*   testSeaweed = new Seaweed();
   testSB = new SubmarineBase(3, 200);*/
}

void draw () {
  drawBackground();
  for (int i = layers.length-1; i >= 0; i--)
    layers[i].draw();
  dd.draw();
    
  /*pushMatrix();
  translate(width/2, height);
  testSeaweed.draw();
  popMatrix();
  pushMatrix();
  translate(0, -300);
  testSub.draw();
  popMatrix();*/
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