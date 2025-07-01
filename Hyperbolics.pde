float cosh(float x) {
  return (pow(e, x) + pow(e, -x))/2;
}

float arcosh(float x) {
  return ln(x + sqrt(x * x - 1));
}

float ln(float x) {
  return log(x) / log(e);
}

int bigNum = 1000000000;
float e = pow(1 + (1 / bigNum), bigNum);
