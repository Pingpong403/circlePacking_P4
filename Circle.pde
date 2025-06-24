class Circle {
  private float distance;
  private float angle;
  
  public Circle() {
    distance = 0;
    angle = 0;
  }
  
  public Circle(float distance, float angle) {
    this.distance = distance;
    this.angle = angle;
  }
  
  public float getDistance() { return distance; }
  public float getAngle() { return angle; }
  
  public void setDistance(float distance) { this.distance = distance; }
  public void setAngle(float angle) { this.angle = angle; }
  
  public void display() {
    noStroke();
    int r;
    int g;
    int b;
    if (this.angle >= 0 && this.angle < (PI / 3)) { // +G
      r = 255;
      g = (int)((this.angle / (PI / 3)) * 255);
      b = 0;
    }
    else if (this.angle >= (PI / 3) && this.angle < (2 * PI / 3)) { // -R
      r = (int)(((2 * PI / 3) - this.angle) / (PI / 3) * 255);
      g = 255;
      b = 0;
    }
    else if (this.angle >= (2 * PI / 3) && this.angle < PI) { // +B
      r = 0;
      g = 255;
      b = (int)(((this.angle - (2 * PI / 3)) / (PI / 3)) * 255);
    }
    else if (this.angle >= PI && this.angle < (4 * PI / 3)) { // -G
      r = 0;
      g = (int)(((4 * PI / 3) - this.angle) / (PI / 3) * 255);
      b = 255;
    }
    else if (this.angle >= 4 * PI / 3 && this.angle < 5 * PI / 3) { // +R
      r = (int)(((this.angle - 4 * PI / 3) / (PI / 3)) * 255);
      g = 0;
      b = 255;
    }
    else { // -B
      r = 255;
      g = 0;
      b = (int)((2 * PI - this.angle) / (PI / 3) * 255);
    }
    r *= distance / 250;
    g *= distance / 250;
    b *= distance / 250;
    fill(r, g, b); // 230
    float x = 500 + distance * cos(angle);
    float y = 350 + distance * sin(angle);
    ellipse(x, y, circleSize, circleSize);
  }
}
