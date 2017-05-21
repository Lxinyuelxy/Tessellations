class Curve {
  ArrayList<PVector> parentCurve;
  
  
  public Curve(ArrayList<PVector> parentCurve) {
    this.parentCurve = parentCurve; 
  }
  
  void generatorNewParticles() {
    int flag = 1;
    int thresholdLen = 10;
    for(int i = 1; i < parentCurve.size(); i++) {
      if(i % thresholdLen == 0) {       
        PVector pos = parentCurve.get(i);
        PVector velocity = pos.copy().sub(parentCurve.get(i-1).copy()).mult(flag);
        velocity.rotate(HALF_PI);
        particles.add(new Particle(pos.copy(), velocity, IDCount++));
        flag = -1 * flag;
      }     
    }
  } 
}