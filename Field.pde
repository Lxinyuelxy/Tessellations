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
        if(i == 0 || i == cols-1 || j == 0 || j == rows-1) {
          direction[i][j] = new PVector(width/2-i*side,height/2-j*side);
        }
        else{
          //int x = i*side;
          //int y = j*side;
          //float c = brightness(backgroundImg.pixels[x + y * backgroundImg.width]);
          direction[i][j] = new PVector(3,5);
          direction[i][j] = direction[i][j].rotate(random(-PI/4,PI/4));
          direction[i][j].normalize();
        }       
      }
    }
  }
  
  void display() {  //<>//
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