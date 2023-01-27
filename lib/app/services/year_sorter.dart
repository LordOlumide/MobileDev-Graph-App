import 'dart:developer';

String yearSorter(int year) {
  if (year >= 0 && year < 20) {
    return '<20';
  } else if (year >= 20 && year <= 24) {
    return '20 - 24';
  } else if (year >= 25 && year <= 29) {
    return '25 - 29';
  } else if (year >= 30 && year <= 34) {
    return '30 - 34';
  } else if (year >= 35 && year <= 39) {
    return '35 - 39';
  } else if (year >= 40 && year <= 44) {
    return '40 - 44';
  } else if (year >= 45 && year <= 49) {
    return '45 - 49';
  } else if (year >= 50 && year <= 54) {
    return '50 - 54';
  } else if (year >= 55 && year <= 59) {
    return '55 - 59';
  } else if (year >= 60 && year <= 200) {
    return '60+';
  } else {
    log(year.toString());
    throw Exception('Invalid year passed to function yearSorted');
  }
}
