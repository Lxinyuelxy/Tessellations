class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  ArrayList<PVector> path;
  
  public Particle(PVector position, float maxspeed, float maxforce) {
    path = new ArrayList<PVector>();
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
    path.add(position);
    acceleration.mult(0);
  }
  
  private void display() {
    beginShape();
    stroke(255);
    strokeWeight(1);
    noFill();
    pushMatrix();
    translate(position.x,position.y);
    ellipse(0,0,3,3);
    popMatrix();
    endShape();
   
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
  
  public boolean isEndMove(){
    Curve parentCurve = new Curve(path);
    parentCurve.generatorNewParticles();
    return false;
  }
}