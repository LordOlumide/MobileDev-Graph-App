import 'dart:convert';
import 'package:flutter/services.dart';

class DataRepo {
  // // TODO: change home screen state to depend on this, not file
  // static late Future<bool> initializationProcess;
  static late Future<List<Map<String, dynamic>>> file;

  // These variables are only available after decodeFile() completes
  /// For section 1
  static late int widowCount;

  /// For section 2
  static late int lgaCount;

  /// For section 3
  /// Format: {'lga': 'String', 'count': int}
  static late List<Map<String, dynamic>> lgaData;

  /// For section 8
  static late List<Map<String, dynamic>> occupationData;

  static Future<void> initialize() async {
    file = decodeFile();
  }

  static Future<List<Map<String, dynamic>>> decodeFile() async {
    final String fileString =
        await rootBundle.loadString('assets/jsons/json_data.json');
    late final List<Map<String, dynamic>> contents =
        jsonDecode(fileString).cast<Map<String, dynamic>>();

    calculateVars(contents);

    // contents[0] = {ngoName: null, fullName: Jayeola Idayat,
    //husbandOccupation: Skilled Manual Labour (Tailoring, Hairdressing etc),
    //accountName: null, address: L/10 Bankole Street, ngoMembership: NO,
    //husbandName: Busiyi Jayeola, employmentStatus: Self Employed, state: Ondo,
    // numberOfChildren: 5, occupation: Sales and Services (Trading),
    //id: ANE000082, dob: 1974-01-01T00:00:00.000, phoneNumber: 07010870233,
    //husbandBereavementDate: 09 May, 2017, homeTown: Ikare, bankName: null,
    //senatorialZone: Ondo North Senatorial District, lga: Akoko North East,
    //yearOfMarriage: 2007, accountNumber: null, categoryBasedOnNeeds: Level 3,
    //oneOrTwo: null, registrationDate: 2020-01-30T00:00:00.000, receivedBy: null}
    return contents;
  }

  static void calculateVars(List<Map<String, dynamic>> contents) {
    final List<Map<String, dynamic>> lgasToFreqList = [];
    final List<Map<String, dynamic>> occupationTypeToFreqList = [];

    for (Map<String, dynamic> widowData in contents) {
      final String widowLga = widowData['lga'];
      late final String occupation;
      try {
        occupation = widowData['occupation'];
      } on TypeError {
        occupation = 'unemployed';
      }
      bool lgaMatchFound = false;
      bool occupationMatchFound = false;

      for (Map<String, dynamic> lgaToFreq in lgasToFreqList) {
        if (lgaToFreq['lga'] == widowLga) {
          lgaToFreq['count']++;
          lgaMatchFound = true;
          break;
        }
      }
      for (Map<String, dynamic> occupationType in occupationTypeToFreqList) {
        if (occupationType['occupation'] == occupation) {
          occupationType['count']++;
          occupationMatchFound = true;
          break;
        }
      }
      if (occupationTypeToFreqList.isEmpty) {
        print('KPl');
      }

      if (lgaMatchFound == false) {
        lgasToFreqList.add({'lga': widowLga, 'count': 1});
      }
      if (occupationMatchFound == false) {
        occupationTypeToFreqList.add({'occupation': occupation, 'count': 1});
      }
    }

    lgaCount = lgasToFreqList.length;
    widowCount = lgasToFreqList.fold<int>(
        0, (previousValue, element) => previousValue + element['count'] as int);
    lgaData = [...lgasToFreqList];

    occupationData = [...occupationTypeToFreqList];
    print(occupationData);
    print(occupationData.length);
  }
}
