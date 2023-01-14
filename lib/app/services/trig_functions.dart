import 'dart:math';

double customSine(double angleInRadians) {
  if (angleInRadians < 180) {
    return sin(angleInRadians);
  } else if (angleInRadians >= 180 && angleInRadians < 270) {
    return -sin(angleInRadians - 180);
  } else if (angleInRadians >= 270 && angleInRadians <= 360) {
    return -sin(360 - angleInRadians);
  } else {
    return sin(angleInRadians);
  }
}

double customCosine(double angleInRadians) {
  if (angleInRadians < 180) {
    return cos(angleInRadians);
  } else if (angleInRadians >= 180 && angleInRadians < 270) {
    return -cos(angleInRadians - 180);
  } else if (angleInRadians >= 270 && angleInRadians <= 360) {
    return cos(360 - angleInRadians);
  } else {
    return cos(angleInRadians);
  }
}
