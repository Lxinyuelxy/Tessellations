class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  ArrayList<PVector> path;
  //PVector originDirection;
  float q;

  public Particle(PVector position, PVector initialVelocity) {
    this.position = position;
    this.acceleration = new PVector(0, 0);
    this.velocity = initialVelocity;
    path = new ArrayList<PVector>();
  }
  
  public void run() {
    update();
    display();
  }
  
  private void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);    
    acceleration.mult(0);
    path.add(position.copy());
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
    endShape();  //<>//
  }
  
  public void followField(Field field) {
    if(velocity == null) {
      float x = random(width);
      float y = random(height);
      velocity = new PVector(x, y).normalize();
    }
    PVector desired = field.lookup((float)getCharge(), velocity.rotate(random(-PI/6, PI/8)));   
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  private double getCharge() {
    double time = (millis() - initialTime) / 1000.0;
    return Math.pow(500 - time, 0.5);
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
    for(PVector p : allPaths) {
      if(p.x == position.x && p.y == position.y) return true;          
    }
    return false;   
  }
  
  public ArrayList<PVector> getPath() {
    return path;
  }
}