import java.util.LinkedList;
import java.util.Map;
import java.util.HashMap;
import controlP5.*;
import gab.opencv.*;

PImage backgroundImg;
Field field;
LinkedList<Particle> particles;
HashMap<Integer, ArrayList<PVector>> trailsOfParticles;
final boolean ISEDGE = true;

int initialTime;
int IDCount = 0;
GUI gui;

void settings() { 
  backgroundImg = loadImage("8.jpg");
  size(backgroundImg.width, backgroundImg.height);
  initialTime = millis();
}

void setup() {
  gui = new GUI(this);
  gui.setup();
  
  field = new Field();
  particles = new LinkedList<Particle>();
  trailsOfParticles = new HashMap<Integer, ArrayList<PVector>>();
  
  //SobelEdgeDetection sobel = new SobelEdgeDetection();
  //edge = sobel.getEdges(backgroundImg);
  //Curve parentCurve = new Curve(edge, true);
  //parentCurve.generatorNewParticles(); 
  //trailsOfParticles.put(IDCount++, edge);
  
  
  
  OpenCV opencv = new OpenCV(this, backgroundImg);
  opencv.gray();
  opencv.threshold(50);
  ArrayList<Contour> contours = opencv.findContours();
  
  for (Contour contour : contours) {
    ArrayList<PVector> edge = new ArrayList<PVector>();
    for (PVector point : contour.getPoints()) {
      println("contour.getPoints().size() = " + contour.getPoints().size());
      edge.add(new PVector(point.x, point.y));
    }
    //edges.add(edge);
    trailsOfParticles.put(IDCount++, edge);
    Curve parentCurve = new Curve(edge, ISEDGE);
    parentCurve.generatorNewParticles();  
  } 
}

void draw() {
  background(255, 255, 255);
  for(int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i);
    p.followField(field);
    p.update();
    ArrayList<PVector> path = p.getPath();
    if(p.isEndMove()) {   
      Curve parentCurve = new Curve(path, false);      
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