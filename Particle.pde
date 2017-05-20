class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  ArrayList<PVector> path;
  float q;
  PVector previous;
  int id;

  public Particle(PVector position, PVector velocity, int id) {
    this.position = position;
    this.acceleration = new PVector(0, 0);
    this.velocity = velocity;
    path = new ArrayList<PVector>();
  }
  
  private void update() {
    path.add(position.copy());
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    acceleration.mult(0);
    previous = position.copy();
    position.add(velocity);         
  }
  
  private void display() {
    beginShape();
    stroke(255);
    strokeWeight(1);
    noFill();
    for(PVector v : path) {
      vertex(v.x, v.y);
    }
    pushMatrix();
    translate(position.x,position.y);
    ellipse(0,0,1,1);
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
    return arriveBorders() || occurOtherCurves(previous.copy(), position.copy());
  }
  
  private boolean arriveBorders(){
    if(position.x <= 0 || position.x >= width || position.y <= 0 || position.y >= height)
      return true;
     else
       return false;
  }
  
  private boolean occurOtherCurves(PVector previousPos, PVector updatedPos) { //<>//
    for(ArrayList<PVector> trail : trailsOfParticles) {
      float dis1 = minDistanceOfPointToLine(previousPos.copy(), trail);   
      float dis2 = minDistanceOfPointToLine(updatedPos.copy(), trail);     
      if(dis1 > dis2 && dis2 <= maxspeed) {
        println("*******************");
        println("previousPos.copy() = " + previousPos.copy());
        println("updatedPos = " + updatedPos);
        println("dis1 = " + dis1);
        println("dis2 = " + dis2);
        return true;
      }
    }
    return false;   
  }
  
  float minDistanceOfPointToLine(PVector point, ArrayList<PVector> trail) {
    float minDis = dist(point.x, point.y, trail.get(0).x, trail.get(0).y);
    for(int i = 1; i < trail.size(); i++) {
      float dis = dist(point.x, point.y, trail.get(i).x, trail.get(i).y);
      if(dis < minDis) minDis = dis;
    }
    return minDis;
  }
 
  public ArrayList<PVector> getPath() {
    return path;
  }
}