int initializeSumTotal(data) {
  int total = data.fold(
      0, (previousValue, element) => element['count'] + previousValue);
  return total;
}
