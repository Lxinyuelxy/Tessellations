import java.util.LinkedList;
import java.util.Map;
import java.util.HashMap;

PImage backgroundImg;
Field field;
LinkedList<Particle> particles;
HashMap<Integer, ArrayList<PVector>> trailsOfParticles;

int initialTime;
int IDCount = 0;

void settings() { 
  backgroundImg = loadImage("7.jpg");
  size(backgroundImg.width, backgroundImg.height);
  initialTime = millis();
}

void setup() {
  background(255, 255, 255);
  field = new Field();
  particles = new LinkedList<Particle>();
  trailsOfParticles = new HashMap<Integer, ArrayList<PVector>>();
  
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(1.5, 0), IDCount++));
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(-1.5, 0), IDCount++));
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(0, 1.5), IDCount++));
}

void draw() {
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