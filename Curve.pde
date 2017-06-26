class Curve {
  ArrayList<PVector> curve;
  
  public Curve(ArrayList<PVector> curve) {
    this.curve = curve; 
  }
  
  void generatorNewParticles() {
    int flag = 1;
    //int thresholdLen = gui.getThreshold();
    int thresholdLen = 30;
    for(int i = 1; i < curve.size(); i++) {
      if(i % thresholdLen == 0) {       
        PVector pos = curve.get(i);
        PVector velocity = pos.copy().sub(curve.get(i-1).copy()).mult(flag);
        velocity.rotate(HALF_PI);
        particles.add(new Particle(pos.copy(), velocity, IDCount++));
        
        //beginShape();
        //stroke(color(0,0,0));
        //strokeWeight(8);
        //vertex(pos.copy().x, pos.copy().y);
        //endShape();
        
        flag = -1 * flag;
      }     
    }
  } 
}