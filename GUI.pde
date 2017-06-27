import controlP5.*;

class GUI {
  ControlP5 cp5;
  Slider slider_radius;
  Slider slider_alpha;
  Slider slider_thickness;
  Slider slider_color;
  
  GUI(PApplet thePApplet) {
    cp5 = new ControlP5(thePApplet);
  }
  
  void setup(){
    cp5.setColorBackground(0x141414);  
    
    slider_color = cp5.addSlider("color")
                 .setPosition(0,5)
                 .setRange(0, 255)
                 .setValue(0).setSize(100,20);
                 
   slider_thickness = cp5.addSlider("thickness")
                 .setPosition(0,28)
                 .setRange(0.5,10)
                 .setValue(2.4).setSize(100,20);  
  }
  
  float getThickness() {
    return slider_thickness.getValue();
  }
  
  int getColor() {
     return int(slider_color.getValue());
  }
  
}