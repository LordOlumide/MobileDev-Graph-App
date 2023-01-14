double calculateAngle({required int quantity, required int total}) {
  return double.parse(((quantity / total) * 360).toStringAsFixed(3));
}
