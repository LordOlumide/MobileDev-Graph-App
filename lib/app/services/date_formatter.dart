/// Input "09 May, 2017"
String formatToDateTimeAcceptable(String input) {
  List<String> i = input.split(' ');
  String year = i[2];
  String month = getMonthNum(i[1].replaceFirst(',', '')).toString();
  month = month.length < 2 ? '0$month' : month;
  String day = i[0];

  return '$year-$month-$day';
}

int getMonthNum(String month) {
  switch (month) {
    case 'January':
      return 1;
    case 'February':
      return 2;
    case 'March':
      return 3;
    case 'April':
      return 4;
    case 'May':
      return 5;
    case 'June':
      return 6;
    case 'July':
      return 7;
    case 'August':
      return 8;
    case 'September':
      return 9;
    case 'October':
      return 10;
    case 'November':
      return 11;
    case 'December':
      return 12;

    default:
      throw Exception('Invalid month passed to function getMonthNum');
  }
}
