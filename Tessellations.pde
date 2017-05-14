import java.util.LinkedList;

PImage backgroundImg;
boolean showField = false;
int startTime;
Field field;
LinkedList<Particle> particles;
ArrayList<PVector> allPaths;
float maxspeed, maxforce; //<>//

void settings() { 
  backgroundImg = loadImage("6.jpg");
  size(backgroundImg.width, backgroundImg.height);
}

void setup() {
  field = new Field(24);
  allPaths = new ArrayList<PVector>();
  particles = new LinkedList<Particle>();
  maxspeed = 3;
  maxforce = 2;
  particles.add(new Particle(new PVector(width/2, height/2), null));
}

void draw() {
  background(255);
  image(backgroundImg, 0, 0);
  if(showField) field.display();
  
  for(int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.followField(field);
    p.run();
    if(p.isEndMove()) {
      particles.remove(i);
      Curve parentCurve = new Curve(p.getPath());
      parentCurve.generatorNewParticles();
    }
  }
}


void keyPressed() {
  if(key == ' ')
    showField = !showField;
}