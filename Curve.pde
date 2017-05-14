class Curve {
  ArrayList<PVector> parentCurve;
  int thresholdLen = 20;
  
  public Curve(ArrayList<PVector> parentCurve) {
    this.parentCurve = parentCurve;
    allPaths.addAll(parentCurve);
  }
  
  void generatorNewParticles() {
    int flag = 1;
    for(int i = 0; i < parentCurve.size(); i++) {
      if(i != 0 && i % thresholdLen == 0) {
        PVector pos = parentCurve.get(i);
        PVector originDirection = pos.copy().sub(parentCurve.get(i-1));
        originDirection = new PVector(-originDirection.y, originDirection.x);
        particles.add(new Particle(pos, originDirection.mult(flag)));
        flag = -1 * flag;
      }     
    }
  }
  
}