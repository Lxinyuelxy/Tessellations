import java.util.LinkedList;
import java.util.Map;
import java.util.HashMap;
import controlP5.*;

PImage backgroundImg;
Field field;
LinkedList<Particle> particles;
HashMap<Integer, ArrayList<PVector>> trailsOfParticles;

int initialTime;
int IDCount = 1;
GUI gui;

void settings() { 
  backgroundImg = loadImage("2.jpg");
  size(backgroundImg.width, backgroundImg.height);
  initialTime = millis();
}

void setup() {
  gui = new GUI(this);
  gui.setup();
  
  field = new Field();
  particles = new LinkedList<Particle>();
  trailsOfParticles = new HashMap<Integer, ArrayList<PVector>>();
  
  //particles.add(new Particle(new PVector(width/2, height/2), new PVector(1.5, 0), IDCount++));
  //particles.add(new Particle(new PVector(width/2, height/2), new PVector(-1.5, 0), IDCount++));
  //particles.add(new Particle(new PVector(width/2, height/2), new PVector(0, 1.5), IDCount++));
  
  SobelEdgeDetection sobel = new SobelEdgeDetection();
  ArrayList<PVector> edge = sobel.getEdges(backgroundImg);
  trailsOfParticles.put(0, edge);
  
}

void draw() {
  //image(backgroundImg, 0, 0);
  background(255, 255, 255);
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
    for (PVector pos : path) {  
      beginShape();
      stroke(color(0,0,0));
      strokeWeight(2);
      noFill();
      vertex(pos.x, pos.y);
      endShape(); 
    } 
  }   
}