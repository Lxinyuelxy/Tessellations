class Field {
  PVector B = new PVector(0, 0, -1);
    
  Field() {
    super(); 
  }
   //<>//
  PVector lookup(float q, PVector velocity) {
    return velocity.cross(B).mult(q);
  }
}