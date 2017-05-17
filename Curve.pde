class Curve {
  ArrayList<PVector> parentCurve;
  int thresholdLen = 30;
  
  public Curve(ArrayList<PVector> parentCurve) {
    this.parentCurve = parentCurve; 
  }
  
  void generatorNewParticles() {
    int flag = 1;
    for(int i = 1; i < parentCurve.size(); i++) {
      if(i % thresholdLen == 0) {
        PVector pos = parentCurve.get(i);
        PVector velocity = pos.copy().sub(parentCurve.get(i-1).copy()).mult(flag);
        velocity.rotate(HALF_PI);
        particles.add(new Particle(pos.copy(), velocity));
        flag = -1 * flag;
      }     
    }
  } 
}