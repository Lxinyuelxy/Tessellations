import java.util.LinkedList;
import java.util.Map;
import java.util.HashMap;
import controlP5.*;

PImage backgroundImg;
Field field;
LinkedList<Particle> particles;
HashMap<Integer, ArrayList<PVector>> trailsOfParticles;
float maxspeed, maxforce;
int initialTime;
int IDCount = 0;
GUI gui;

void settings() { 
  backgroundImg = loadImage("7.jpg");
  size(backgroundImg.width, backgroundImg.height);
  initialTime = millis();
}

void setup() {
  background(255);
  field = new Field();
  particles = new LinkedList<Particle>();
  trailsOfParticles = new HashMap<Integer, ArrayList<PVector>>();
  maxspeed = 3; //the curve is more straight with the maxspeed faster
  maxforce = 0.8; // the curve is more straight with the maxforce smaller
  
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(1.5, 0), IDCount++));
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(-1.5, 0), IDCount++));
  particles.add(new Particle(new PVector(width/2, height/2), new PVector(0, 1.5), IDCount++));
  
  gui = new GUI(this);
  gui.setup();
}

void draw() {
  image(backgroundImg, 0, 0);
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
    //else p.display();       
  }  
  display();
}

void display() {
  for (ArrayList<PVector> path : trailsOfParticles.values()) {  
    beginShape();
    stroke(gui.getColor());
    strokeWeight(gui.getThickness());
    noFill();
    for(PVector v : path) {
      vertex(v.x, v.y);
    }
    endShape(); 
  }  
}