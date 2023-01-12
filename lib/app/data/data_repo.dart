import 'dart:convert';
import 'package:flutter/services.dart';

class DataRepo {
  // // TODO: change home screen state to depend on this, not file
  // static late Future<bool> initializationProcess;
  static late Future<List<Map<String, dynamic>>> file;

  // These variables are only available after decodeFile() completes
  static late int lgaCount;
  static late int widowCount;
  // {'lga': 'String', 'count': int}
  static late List<Map<String, dynamic>> lgaAndWidowCount;

  static Future<void> initialize() async {
    file = decodeFile();
  }

  static Future<List<Map<String, dynamic>>> decodeFile() async {
    final String fileString =
        await rootBundle.loadString('assets/jsons/json_data.json');
    late final List<Map<String, dynamic>> contents =
        jsonDecode(fileString).cast<Map<String, dynamic>>();

    calculateLGAVars(contents);

    return contents;
  }

  static void calculateLGAVars(List<Map<String, dynamic>> contents) {
    final List<Map<String, dynamic>> lgasToFreqList = [];
    for (Map<String, dynamic> widowData in contents) {
      final String widowLga = widowData['lga'];
      bool matchFound = false;

      for (Map<String, dynamic> lgaToFreq in lgasToFreqList) {
        if (lgaToFreq['lga'] == widowLga) {
          lgaToFreq['count']++;
          matchFound = true;
          break;
        }
      }
      if (matchFound == false) {
        lgasToFreqList.add({'lga': widowLga, 'count': 1});
      }
    }

    lgaCount = lgasToFreqList.length;
    widowCount = lgasToFreqList.fold<int>(
        0, (previousValue, element) => previousValue + element['count'] as int);
    lgaAndWidowCount = [...lgasToFreqList];
  }
}
