import java.util.LinkedList;

PImage backgroundImg;
int startTime;
Field field;
LinkedList<Particle> particles;
ArrayList<PVector> trail;
float maxspeed, maxforce;
int side = 24; //<>//
int initialTime;

void settings() { 
  backgroundImg = loadImage("6.jpg");
  size(backgroundImg.width, backgroundImg.height);
  initialTime = millis();
}

void setup() {
  background(255);
  field = new Field();
  trail = new ArrayList<PVector>();
  particles = new LinkedList<Particle>();
  maxspeed = 5;
  maxforce = 0.1;
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(1.5, 2)));
}

void draw() {
  //background(255);
  //image(backgroundImg, 0, 0);

  for(int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.followField(field);
    p.run();
    if(p.isEndMove()) {     
      ArrayList<PVector> path = p.getPath();
      Curve parentCurve = new Curve(path);      
      particles.remove(i); 
      parentCurve.generatorNewParticles();   
      i--;
    }   
  }  
}