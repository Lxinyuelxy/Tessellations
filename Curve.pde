class Curve {
  ArrayList<PVector> curve;
  int thresholdLen;
  color strokeColor;
  
  public Curve(ArrayList<PVector> curve, boolean isEdge) {
    this.curve = curve;   
    if(isEdge) 
      thresholdLen = 60;    
    else 
      thresholdLen = 20;     
  }
  
  void generatorNewParticles() {
    int flag = 1;
    //int thresholdLen = gui.getThreshold();
    
    for(int i = 1; i < curve.size(); i++) {
      if(i % thresholdLen == 0) {       
        PVector pos = curve.get(i);
        PVector velocity = pos.copy().sub(curve.get(i-1).copy()).mult(flag);
        velocity.rotate(HALF_PI);
        //velocity.rotate(random(HALF_PI - PI/6, HALF_PI + PI/6));
        particles.add(new Particle(pos.copy(), velocity, IDCount++));
        flag = -1 * flag;
      }     
    }
  } 
}