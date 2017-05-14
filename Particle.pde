class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  ArrayList<PVector> path = new ArrayList<PVector>();
  PVector originDirection;
  
  public Particle(PVector position, PVector originDirection) {
    this.position = position;
    this.originDirection = originDirection;
    this.acceleration = new PVector(0, 0);
    this.velocity = new PVector(0, 0);
  }
  public void run() {
    update();
    display();
  }
  
  private void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    path.add(position.copy());
    acceleration.mult(0);
  }
  
  private void display() {
    beginShape();
    stroke(0);
    strokeWeight(2);
    noFill();
    for(PVector v : path) {
      vertex(v.x, v.y);
    }
    pushMatrix();
    translate(position.x,position.y);
    ellipse(0,0,3,3);
    popMatrix();
    endShape(); //<>// //<>//
  }
  
  public void followField(Field field) {
    PVector desired;
    if(originDirection == null) {
      desired = field.lookup(position);
    }else{
      desired = originDirection;
      //originDirection = null;
    }   
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  private void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  public boolean isEndMove(){
    if(arriveBorders() || occurOtherCurves()) 
      return true;
     else
       return false;
  }
  
  private boolean arriveBorders(){
    if(position.x <= 0 || position.x >= width || position.y <= 0 || position.y >= height)
      return true;
    else
      return false;
  }
  
  private boolean occurOtherCurves() {
    if(allPaths.contains(position)) {
      return true;
    }      
    else {
      
      return false;
    }
      
  }
  
  public ArrayList<PVector> getPath() {
    return path;
  }
}