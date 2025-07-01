class Button
{
  private Position pos;
  private String text;
  private int w = 100;
  private int h = 40;
  private boolean pressed = false;
  
  public Button()
  {
    pos = new Position();
    text = "";
  }
  
  public Button(Position pos, String text)
  {
    this.pos = pos;
    this.text = text;
  }
  
  public Button(Position pos, String text, int w, int h)
  {
    this.pos = pos;
    this.text = text;
    this.w = w;
    this.h = h;
  }
  
  public String getText() { return text; }
  public boolean isPressed() { return pressed; }
  
  public void setText(String text) { this.text = text; }
  
  public boolean isMouseWithin()
  {
    return mouseX > pos.x && mouseX < pos.x + w &&
           mouseY > pos.y && mouseY < pos.y + h;
  }
  
  public void press  () { pressed = true;  }
  public void unpress() { pressed = false; }
  
  public void display()
  {
    rectMode(CORNER);
    stroke(pressed ? 230 : 0);
    strokeWeight(1);
    fill(pressed ? 128 : 230);
    rect(pos.x, pos.y, w, h, 15);
    fill(pressed ? 230 : 0);
    textAlign(CENTER);
    textSize(h * 3 / 4);
    text(text, pos.x + (w / 2), pos.y + (h * 3 / 4));
  }
}
