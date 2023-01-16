import '../../constants/app_theme.dart';
import 'package:flutter/material.dart';

Color getEmploymentStatusColor(String status) {
  switch (status) {
    case 'Self Employed':
      return deepYellow;
    case 'Unemployed':
      return normalYellow.withOpacity(0.51);
    case 'Employed':
      return deepBlue;
    case 'Pensioner':
      return normalBlue;
    case 'Unknown':
      return Colors.grey;
    default:
      throw Exception('Invalid String passed to getEmploymentStatusColor');
  }
}
