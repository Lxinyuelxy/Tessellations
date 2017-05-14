import java.util.LinkedList;

PImage backgroundImg;
boolean showField = true;
int startTime;
Field field;
LinkedList<Particle> particles;
ArrayList<PVector> allPaths; //<>//

void settings() { 
  backgroundImg = loadImage("9.jpg");
  size(backgroundImg.width, backgroundImg.height);
}

void setup() {
  field = new Field(16);
  allPaths = new ArrayList<PVector>();
  particles = new LinkedList<Particle>();
  particles.add(new Particle(new PVector(width/2, height/2), 3, 0.3));
}

void draw() {
  //background(backgroundImg);
  background(255);
  //image(backgroundImg, 0, 0);
  if(showField) field.display();
  
  for(int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.followField(field);
    p.run();
    if(p.isEndMove() != null) {
      particles.remove(i);
      Curve parentCurve = new Curve(p.isEndMove());
      parentCurve.generatorNewParticles();
    }
  }
}


void keyPressed() {
  if(key == ' ')
    showField = !showField;
}