class Slider
{
  private Position pos;
  private String label;
  private int h;
  private float ratio;
  
  public Slider() {
    pos = new Position();
    label = "";
    h = 200;
    ratio = 0;
  }
  
  public Slider(Position pos, String label) {
    this.pos = pos;
    this.label = label;
    this.h = 200;
    ratio = 0;
  }
  
  public Slider(Position pos, String label, int h) {
    this.pos = pos;
    this.label = label;
    this.h = h;
    ratio = 0;
  }
  
  public Slider(Position pos, String label, int h, float ratio) {
    this.pos = pos;
    this.label = label;
    this.h = h;
    this.ratio = ratio;
  }
  
  public Position getPosition() { return pos; }
  public String getLabel() { return label; }
  public int getHeight() { return h; }
  public float getRatio() { return ratio; }
  
  //public void setPosition(Position pos) { this.pos = pos; }
  //public void setLabel(String label) { this.label = label; }
  //public void setHeight(int h) { this.h = h; }
  public void setRatio(float ratio) { this.ratio = ratio; }
  
  public boolean isMouseWithin() {
    // rect(pos.getX(), pos.getY() - h * ratio, 20, 40);
    return mouseX > pos.x - 10 &&
           mouseX < pos.x + 10 &&
           mouseY > pos.y - h * ratio - 20 &&
           mouseY < pos.y - h * ratio + 20;
  }
  
  public void calcRatio() {
    float diff = pos.y - mouseY;
    if (diff > h) {
      ratio = 1;
    }
    else if (diff < 0) {
      ratio = 0;
    }
    else {
      ratio = diff / h;
    }
  }
  
  public void display() {
    // draw label
    fill(0);
    noStroke();
    textSize(20);
    textAlign(CENTER);
    text(label, pos.x, pos.y - h - 20);
    
    // draw slide track
    stroke(0);
    line(pos.x, pos.y, pos.x, pos.y - h);
    
    // draw tick marks
    for (float i = 0; floatHelper(i, 100) || i < 100.0; i+=0.01) {
      float percentage = i / 100.0;
      if (floatHelper(i % 25, 0)) {
        line(pos.x - 7, pos.y - h * percentage, pos.x + 7, pos.y - h * percentage);
      }
      else if (floatHelper(i % (25.0 / 2.0), 0)) {
        line(pos.x - 4, pos.y - h * percentage, pos.x + 4, pos.y - h * percentage);
      }
      else if (floatHelper(i % (25.0 / 4.0), 0)){
        line(pos.x - 1, pos.y - h * percentage, pos.x + 1, pos.y - h * percentage);
      }
    }
    
    // draw slider knob
    rectMode(CENTER);
    stroke(128);
    strokeWeight(1);
    fill(255);
    rect(pos.x, pos.y - h * ratio, 20, 40);
    fill(200);
    rect(pos.x, pos.y - h * ratio, 20, 40 * 0.75);
    fill(145);
    rect(pos.x, pos.y - h * ratio, 20, 40 * 0.5);
    fill(85);
    rect(pos.x, pos.y - h * ratio, 20, 40 * 0.25);
  }
}

boolean floatHelper(float value, float compare)
{
  return value <= compare + 0.01 && value >= compare - 0.01;
}
