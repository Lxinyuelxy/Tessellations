import controlP5.*;

class GUI {
  ControlP5 cp5;
  Slider slider_radius;
  Slider slider_threshold;
  Slider slider_thickness;
  Slider slider_color;
  
  GUI(PApplet thePApplet) {
    cp5 = new ControlP5(thePApplet);
  }
  
  void setup(){
    cp5.setColorBackground(0x141414);
    slider_radius = cp5.addSlider("radius")
                 .setPosition(0,0)
                 .setRange(0.1,1)
                 .setValue(0.1).setSize(100,20);
    slider_threshold = cp5.addSlider("threshold")
                 .setPosition(0,23)
                 .setRange(5,40)
                 .setValue(15).setSize(100,20);  
    slider_color = cp5.addSlider("color")
                 .setPosition(0,46)
                 .setRange(0, 255)
                 .setValue(200).setSize(100,20); 
   slider_thickness = cp5.addSlider("thickness")
                 .setPosition(0,69)
                 .setRange(0.5,10)
                 .setValue(2.3).setSize(100,20);
    
  }
  
  float getRaduis() {
    return slider_radius.getValue();
  }
  
  float getThickness() {
    return slider_thickness.getValue();
  }
  
  int getColor() {
     return int(slider_color.getValue());
  }
  
  int getThreshold() {
    return int(slider_threshold.getValue());
  }
}