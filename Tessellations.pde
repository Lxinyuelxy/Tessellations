PImage backgroundImg;
boolean showField = true;
Field field;

void settings() { //<>//
  backgroundImg = loadImage("face.jpg");
  size(backgroundImg.width, backgroundImg.height);
}

void setup() {
  field = new Field(16);
}

void draw() {
  background(255);
  //image(backgroundImg, 0, 0);
  if(showField) field.display();
}

void keyPressed() {
  if(key == ' ')
    showField = !showField;
}