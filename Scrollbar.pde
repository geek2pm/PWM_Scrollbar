class HScrollbar {
  int swidth, sheight;    // width and height of bar
  int xpos, ypos;       // x and y position of bar
  int spos, newspos;    // x position of slider
  int sposMin, sposMax; // max and min values of slider
  boolean over;           // is the mouse over the slider?
  boolean locked;

  HScrollbar (int x, int y, int w, int h) {
    swidth = w;
    sheight = h;
    xpos = x;
    ypos = y-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos);
    }
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    fill(25, 25, 25);
    rect(spos, ypos, sheight, sheight);
  }
  int getPos() {
    return (int)(spos*(float)255/sposMax);
  }
  void pwmWrite(Arduino arduino,int pin){
    arduino.analogWrite(pin, getPos());
  }
}
