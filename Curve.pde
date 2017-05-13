class Curve {
  ArrayList<PVector> parentCurve;
  int thresholdLen = 20;
  
  public Curve(ArrayList<PVector> parentCurve) {
    this.parentCurve = parentCurve;
  }
  
  void generatorNewParticles() {
    for(int i = 0; i < parentCurve.size(); i++) {
      if(i % thresholdLen == 0)
        particles.add(new Particle(parentCurve.get(i), 3, 0.3));
    }
  }
  
}