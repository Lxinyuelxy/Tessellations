class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  ArrayList<PVector> path = new ArrayList<PVector>();
  
  
  public Particle(PVector position, float maxspeed, float maxforce) {
    this.position = position;
    this.maxspeed = maxspeed;
    this.maxforce = maxforce;
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
    allPaths.add(position);
    acceleration.mult(0);
  }
  
  private void display() {
    beginShape();
    stroke(0);
    strokeWeight(3);
    noFill();
    for(PVector v : path) {
      vertex(v.x, v.y);
    }
    pushMatrix();
    translate(position.x,position.y);
    ellipse(0,0,3,3);
    popMatrix();
    endShape();
 //<>// //<>//
  }
  public void followField(Field field) {
    PVector desired = field.lookup(position);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  
  private void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  public ArrayList<PVector> isEndMove(){
    if(arriveBorders()) {
      //Curve parentCurve = new Curve(path);
      //parentCurve.generatorNewParticles();
      return path;
    }
    return null;
  }
  
  private boolean arriveBorders(){
    if(position.x <= 0 || position.x >= width || position.y <= 0 || position.y >= height)
      return true;
    else
      return false;
  }
}