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
double SILVER_RATIO = 1 + sqrt(2);
double BRONZE_RATIO = (3 + sqrt(13)) / 2;
double COPPER_RATIO = 2 + sqrt(5);
double PLASTIC_RATIO = (2 / sqrt(3)) * cosh((1 / 3) * arcosh(3 * sqrt(3) / 2));

float circleSize = (float)2000 / CIRCLE_COUNT + 1;
float spacing = (float)500 / CIRCLE_COUNT;

float angleOfSeparation = (2 * PI) / (float)GOLDEN_RATIO;
float distance = 0;
float angle = 0;

Circle[] circles = new Circle[CIRCLE_COUNT];
Slider angleSlider = new Slider(new Position(950, 670), "Angle", 200, angleOfSeparation / 2 / PI % 1);
Slider dummySlider = new Slider(new Position(), "", 0, 0);
Button phiButton = new Button(new Position(10, 10), "Golden");
Button deltaButton = new Button(new Position(10, 60), "Silver");
Button betaButton = new Button(new Position(10, 110), "Bronze");
Button kappaButton = new Button(new Position(10, 160), "Copper");
Button rhoButton = new Button(new Position(10, 210), "Plastic");

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
    // buttons
    if (phiButton.isMouseWithin()) phiButton.press();
    else phiButton.unpress();
    if (deltaButton.isMouseWithin()) deltaButton.press();
    else deltaButton.unpress();
    if (betaButton.isMouseWithin()) betaButton.press();
    else betaButton.unpress();
    if (kappaButton.isMouseWithin()) kappaButton.press();
    else kappaButton.unpress();
    if (rhoButton.isMouseWithin()) rhoButton.press();
    else rhoButton.unpress();
    
    // sliders
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
    if (phiButton.isMouseWithin()) {
      angleOfSeparation = (2 * PI) / (float)GOLDEN_RATIO;
      angleSlider.setRatio(angleOfSeparation / 2 / PI % 1);
    }
    else if (deltaButton.isMouseWithin()) {
      angleOfSeparation = (2 * PI) / (float)SILVER_RATIO;
      angleSlider.setRatio(angleOfSeparation / 2 / PI % 1);
    }
    else if (betaButton.isMouseWithin()) {
      angleOfSeparation = (2 * PI) / (float)BRONZE_RATIO;
      angleSlider.setRatio(angleOfSeparation / 2 / PI % 1);
    }
    else if (kappaButton.isMouseWithin()) {
      angleOfSeparation = (2 * PI) / (float)COPPER_RATIO;
      angleSlider.setRatio(angleOfSeparation / 2 / PI % 1);
    }
    else if (rhoButton.isMouseWithin()) {
      angleOfSeparation = (2 * PI) / (float)PLASTIC_RATIO;
      angleSlider.setRatio(angleOfSeparation / 2 / PI % 1);
    }
    phiButton.unpress();
    deltaButton.unpress();
    betaButton.unpress();
    kappaButton.unpress();
    rhoButton.unpress();
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
  
  phiButton.display();
  deltaButton.display();
  betaButton.display();
  kappaButton.display();
  rhoButton.display();
  
  angleSlider.display();
  noStroke();
  fill(0);
  textSize(15);
  textAlign(CENTER);
  text(angleOfSeparation, 950, 690);
  
  mouseChoose = false;
}
