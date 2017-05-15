class Curve {
  ArrayList<PVector> parentCurve;
  int thresholdLen = 10;
  
  public Curve(ArrayList<PVector> parentCurve) {
    this.parentCurve = parentCurve; 
    println("parentVurve = " + parentCurve);
    println("parentCurve.size() = " + parentCurve.size());
  }
  
  void generatorNewParticles() {
    int flag = 1;
    for(int i = 0; i < parentCurve.size(); i++) {
      if(i != 0 && i % thresholdLen == 0) {
        PVector pos = parentCurve.get(i);
        PVector originDirection = pos.copy().sub(parentCurve.get(i-1));
        //originDirection = new PVector(-originDirection.y, originDirection.x);
        particles.add(new Particle(pos.copy(), originDirection.mult(flag)));
        flag = -1 * flag;
      }     
    }
  }
  
}