import '../../constants/app_theme.dart';
import 'package:flutter/material.dart';

Color getNGOAffiliationColor(String status) {
  switch (status) {
    case 'YES':
      return deepBlue;
    case 'NO':
      return normalBlue;
    case 'Unknown':
      return Colors.grey;
    default:
      throw Exception('Invalid String passed to getNGOAffiliationColor');
  }
}
