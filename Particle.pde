class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  //PVector initialVelocity;
  ArrayList<PVector> path;
  float q;

  public Particle(PVector position, PVector velocity) {
    this.position = position;
    this.acceleration = new PVector(0, 0);
    //this.initialVelocity = initialVelocity;
    this.velocity = velocity;
    path = new ArrayList<PVector>();
  }
  
  public void run() {
    path.add(position.copy());
    trail.add(position.copy());
    update();
    display();   
  }
  
  private void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);    
    acceleration.mult(0);  
  }
  
  private void display() {
    beginShape();
    stroke(0);
    strokeWeight(1);
    noFill();
    for(PVector v : path) {
      vertex(v.x, v.y);
    }
    pushMatrix();
    translate(position.x,position.y);
    ellipse(0,0,3,3);
    popMatrix();
    endShape(); //<>//
  }
  
  public void followField(Field field) { 
    PVector desired = field.lookup((float)getCharge(), velocity);  
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  private double getCharge() {
    double time = (millis() - initialTime) / 1000.0;
    if(random(0, 1) > 0.5)   
      return Math.pow(500 - time, 0.8);
    else
      return Math.pow(500 - time, 0.8) * (-1);
  }
  
  private void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  public boolean isEndMove(){
    return arriveBorders() || occurOtherCurves();
  }
  
  private boolean arriveBorders(){
    if(position.x <= 0 || position.x >= width || position.y <= 0 || position.y >= height)
      return true;
     else
       return false;
  }
  
  private boolean occurOtherCurves() {
    for(PVector p : trail) {
      if(p.x == position.x && p.y == position.y) {println("occur");return true;}          
    }
    return false;   
  }
  
  public ArrayList<PVector> getPath() {
    return path;
  }
}