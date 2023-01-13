int roundNumUpToNext100(int number) {
  int a = number % 100;

  if (a > 0) {
    return (number ~/ 100) * 100 + 100;
  }

  return number;
}

int roundNumUpToNext10(int number) {
  int a = number % 10;

  if (a > 0) {
    return (number ~/ 10) * 10 + 10;
  }

  return number;
}
