class Field {
  int side;
  int cols, rows;
  PVector[][] direction;
  
  Field(int side) {
    this.side = side;
    cols = width / side;
    rows = height / side;
    direction = new PVector[cols][rows];
    init();   
  }
  
  void init() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        //int x = i*side;
        //int y = j*side;
        //int c = backgroundImg.pixels[x + y * backgroundImg.width];
        //float theta = map(brightness(c), 0, 255, 0, TWO_PI);
        direction[i][j] = PVector.fromAngle(random(TWO_PI));
        //direction[i][j] = PVector.fromAngle(TWO_PI);
        direction[i][j].normalize();
      }
    }
  }
  
  void display() { //<>// //<>//
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
  
  PVector lookup(PVector coordinate) {
    int col = int(constrain(coordinate.x/side, 0, cols-1));
    int row = int(constrain(coordinate.y/side, 0, rows-1));
    return direction[col][row];
  }
}