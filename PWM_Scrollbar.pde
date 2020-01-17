
import processing.serial.*;
Serial myPort;
import cc.arduino.*;
Arduino arduino;
boolean hasDevice;
HScrollbar hs1;  //scrollbars
String title = "PWM ";
void setup() {
  size(800, 360);
  noStroke();
  //PFont myFont = createFont(PFont.list()[2], 80);
  PFont myFont=createFont("SourceCodePro-Regular.ttf", 80);
  fill(0);
  textFont(myFont);
  hs1 = new HScrollbar(0, height/2+48, width, 32);
}

void draw() {
  background(255);
  if (Arduino.list().length>0) {
    if (arduino==null) {
      arduino = new Arduino(this, Arduino.list()[0], 57600);
    }
    hs1.update();
    hs1.display();
    fill(0);
    String title2 = title+hs1.getPos();
    text(title2, width/2-title2.length()*25, height/2);
    hs1.pwmWrite(arduino, 3);
  } else {
    fill(0);
    String err = "No Device Found";
    arduino = null;
    text(err, width/2-err.length()*22, height/2);
  }
}
