import java.util.Iterator;

PImage backgroundImg;
boolean showField = true;
int startTime;
Field field;
ArrayList<Particle> particles;

void settings() { //<>//
  backgroundImg = loadImage("9.jpg");
  size(backgroundImg.width, backgroundImg.height);
}

void setup() {
  field = new Field(16);
  particles = new ArrayList<Particle>();
  particles.add(new Particle(new PVector(0, 0), 3, 0.3));
}

void draw() {
  background(255);
  image(backgroundImg, 0, 0);
  if(showField) field.display();
  Iterator<Particle> it = particles.iterator();
  while(it.hasNext()) {
    Particle p = it.next();
    p.followField(field);
    p.run();
  }
}

void keyPressed() {
  if(key == ' ')
    showField = !showField;
}