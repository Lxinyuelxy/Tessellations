import java.util.LinkedList;

PImage backgroundImg;
boolean showField = true;
int startTime;
Field field;
LinkedList<Particle> particles;
ArrayList<PVector> allPaths;
float maxspeed, maxforce;
int side = 24; //<>//
int initialTime;

void settings() { 
  backgroundImg = loadImage("6.jpg");
  size(backgroundImg.width, backgroundImg.height);
  initialTime = millis();
}

void setup() {
  field = new Field();
  allPaths = new ArrayList<PVector>();
  particles = new LinkedList<Particle>();
  maxspeed = 10000;
  maxforce = 0.8;
  particles.add(new Particle(new PVector(width/2, height/2), null));
}

void draw() {
  background(255);
  //image(backgroundImg, 0, 0);
  //if(showField) field.display();
    
  for(int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.followField(field);
    p.run();
    if(p.isEndMove()) {     
      ArrayList<PVector> path = p.getPath();
      Curve parentCurve = new Curve(path);
      allPaths.addAll(path);
      particles.remove(i);    
      parentCurve.generatorNewParticles();
    }
  }
}