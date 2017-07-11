class Curve {
  ArrayList<PVector> curve; 
  color strokeColor;
  
  public Curve(ArrayList<PVector> curve) {
    this.curve = curve;   
  }
  
  void generatorNewParticles() {
    int flag = 1;
    int thresholdLen = 3;
    for(int i = 1; i < curve.size(); i++) {
      if(i % thresholdLen == 0) {       
        PVector pos = curve.get(i);
        PVector velocity = pos.copy().sub(curve.get(i-1).copy()).mult(flag);
        velocity.rotate(HALF_PI);
        particles.add(new Particle(pos.copy(), velocity, IDCount++));
        flag = -1 * flag;
      }     
    }
  } 
}