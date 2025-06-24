// circle packing
import java.util.Random;

Random rand = new Random();

// CUSTOM MOUSE CLICKING TOOL
boolean mouseChoose = false;
void mouseReleased()
{
  mouseChoose = true;
  // set to false at the end of drawing phase
}

int CIRCLE_COUNT = 1000;
double GOLDEN_RATIO = (1 + sqrt(5)) / 2;

float circleSize = (float)2000 / CIRCLE_COUNT + 1;
float spacing = (float)500 / CIRCLE_COUNT;

float angleOfSeparation = (2 * PI) / (float)GOLDEN_RATIO;
float distance = 0;
float angle = 0;

Circle[] circles = new Circle[CIRCLE_COUNT];
Slider angleSlider = new Slider(new Position(950, 670), "Angle", 200, angleOfSeparation / 2 / PI % 1);
Slider dummySlider = new Slider(new Position(), "", 0, 0);

Slider selectedSlider = dummySlider; // so selectedSlider always points to a slider
boolean sliderPicked = false;

void setup() {
  size(1000, 700);
  for (int i = 0; i < CIRCLE_COUNT; i++) {
    circles[i] = new Circle(distance, angle % (2 * PI));
    float x = (float)i / CIRCLE_COUNT;
    distance += spacing * (1 - (float)x);
    angle += angleOfSeparation;
  }
}

void draw() {
  background(255);
  
  // update slider
  if (mousePressed) {
    if (!sliderPicked) {
      if (angleSlider.isMouseWithin()) {
        selectedSlider = angleSlider;
        sliderPicked = true;
      }
      else selectedSlider = dummySlider;
    }
    else if (sliderPicked) {
      if (selectedSlider == angleSlider) {
        angleSlider.calcRatio();
        angleOfSeparation = angleSlider.getRatio() * 2 * PI;
      }
    }
  }
  if (mouseChoose) {
    selectedSlider = dummySlider;
    sliderPicked = false;
  }
  
  // slowly increase angle if 'a' is pressed; stop at 0 if 's' is pressed
  if (keyPressed) {
    if (key == 'a' || key == 'A') {
      angleOfSeparation += 0.0005;
      if (angleOfSeparation >= 2 * PI) angleOfSeparation = 0;
      angleSlider.setRatio(angleOfSeparation / 2 / PI);
    }
    else if (key == 's' || key == 'S') {
      if (angleOfSeparation != 0) {
        angleOfSeparation += 0.0005;
        if (angleOfSeparation >= 2 * PI) angleOfSeparation = 0;
        angleSlider.setRatio(angleOfSeparation / 2 / PI);
      }
    }
  }
  
  // update circles based on current angle of separation
  distance = 0;
  angle = 0;
  for (int i = 0; i < CIRCLE_COUNT; i++) {
    float x = (float)i / CIRCLE_COUNT;
    distance += spacing * (1 - (float)x);
    angle += angleOfSeparation;
    circles[i].setDistance(distance);
    circles[i].setAngle(angle % (2 * PI));
  }
  
  // display everything
  for (int i = CIRCLE_COUNT - 1; i >= 0; i--) {
    circles[i].display();
  }
  angleSlider.display();
  noStroke();
  fill(0);
  textSize(15);
  textAlign(CENTER);
  text(angleOfSeparation, 950, 690);
  
  mouseChoose = false;
}
