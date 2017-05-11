class Field {
  int side;
  int cols, rows;
  PVector[][] direction;
  
  Field(int side) {
    this.side = side;
    cols = width / side;
    rows = height / side;
    direction = new PVector[rows][cols];
    init();   
  }
  
  void init() {
    loadPixels();
    for(int i = 0; i < cols; i++) {
      for(int j = 0; j < rows; j++) {
        int x = i * side;
        int y = j * side;
        int c = backgroundImg.pixels[x + y * backgroundImg.width];
        
        float theta = map(c, 0, 255, 0, TWO_PI);
        direction[i][j] = PVector.fromAngle(theta);
        direction[i][j].normalize();
      }
    }
  }
  
  void display() { //<>//
    for(int i = 0; i < cols; i++) {
      for(int j = 0; j < rows; j++) {
        drawVector(direction[i][j], i*side, j*side, side - 2);
      }
    }
  }
  
  void drawVector(PVector v, float x, float y, float len) {
    pushMatrix();
    strokeWeight(2);
    stroke(255, 0, 0);
    translate(x, y);
    rotate(v.heading());
    line(0,0,len,0);
    popMatrix();
  }
}