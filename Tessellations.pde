import java.util.LinkedList;

PImage backgroundImg;
int startTime;
Field field;
LinkedList<Particle> particles;
ArrayList<ArrayList<PVector>> trailsOfParticles = new ArrayList<ArrayList<PVector>>();
float maxspeed, maxforce;
int side = 24;
int initialTime;
int IDCount = 0;

void settings() { 
  backgroundImg = loadImage("6.jpg");
  size(backgroundImg.width, backgroundImg.height);
  initialTime = millis();
}

void setup() {
  background(255);
  image(backgroundImg, 0, 0);
  field = new Field();
  particles = new LinkedList<Particle>();
  maxspeed = 2.5; //the curve is more straight with the maxspeed faster
  maxforce = 0.1; // the curve is more straight with the maxforce smaller
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(1.5, 2), IDCount++));
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(-1.5, -2), IDCount++));
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(-2, 1.5), IDCount++));
}

void draw() {
  //background(255);
  for(int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.followField(field);
    p.update();
    ArrayList<PVector> path = p.getPath();
    if(p.isEndMove()) {   
      Curve parentCurve = new Curve(path);      
      particles.remove(i); 
      parentCurve.generatorNewParticles();   
      i--;
    }
    else p.display();       
  }  
}