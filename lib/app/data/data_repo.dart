import 'dart:convert';
import 'package:flutter/services.dart';
import '../services/date_formatter.dart';

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

  /// For section 4
  /// Format: {'employmentStatus': 'String', 'count': int}
  static late List<Map<String, dynamic>> employmentStatusData;

  /// For section 5
  /// Format: {'affliationStatus': 'String', 'count': int}
  static late List<Map<String, dynamic>> ngoAffiliationData;

  /// For section 7
  /// Format: {'ageWhenWidowed': 'String', 'count': int}
  static late List<Map<String, dynamic>> ageWhenWidowedData;

  /// For section 8
  /// Format: {'occupation': 'String', 'count': int}
  static late List<Map<String, dynamic>> occupationData;

  static Future<void> initialize() async {
    file = decodeFileAndCalculatVars();
  }

  static Future<List<Map<String, dynamic>>> decodeFileAndCalculatVars() async {
    final String fileString =
        await rootBundle.loadString('assets/jsons/json_data.json');
    late final List<Map<String, dynamic>> contents =
        jsonDecode(fileString).cast<Map<String, dynamic>>();

    try {
      calculateVars(contents);
    } catch (e) {
      print(e);
    }
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
    // Temporary lists for collating data before
    // assigning them to the static permanent lists
    final List<Map<String, dynamic>> lgasToFreqList = [];
    final List<Map<String, dynamic>> employmentStatusToFreqList = [];
    final List<Map<String, dynamic>> ngoAffiliationToFreqList = [];
    final List<Map<String, dynamic>> widowedAgeToFreqList = [];
    final List<Map<String, dynamic>> occupationTypeToFreqList = [];

    // Loop for extracting the data
    for (Map<String, dynamic> widowData in contents) {
      final String widowLga = widowData['lga'];

      late final String employmentStatus = widowData['employmentStatus'];
      late final String ngoMembershipStatus = widowData['ngoMembership'];
      final int ageWhenWidowedInYears = getAgeWhenWidowed(widowData);
      late final String occupation = widowData['occupation'] ?? 'Unemployed';

      bool lgaMatchFound = false;
      bool employmentStatusMatchFound = false;
      bool ngoMembershipStatusMatchFound = false;
      bool occupationMatchFound = false;
      bool ageWhenWidowedMatchFound = false;

      for (Map<String, dynamic> lga in lgasToFreqList) {
        if (lga['lga'] == widowLga) {
          lga['count']++;
          lgaMatchFound = true;
          break;
        }
      }
      for (Map<String, dynamic> status in employmentStatusToFreqList) {
        if (status['employmentStatus'] == employmentStatus) {
          status['count']++;
          employmentStatusMatchFound = true;
          break;
        }
      }
      for (Map<String, dynamic> membershipStatus in ngoAffiliationToFreqList) {
        if (membershipStatus['affliationStatus'] == ngoMembershipStatus) {
          membershipStatus['count']++;
          ngoMembershipStatusMatchFound = true;
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
      for (Map<String, dynamic> ageWhenWidowed in widowedAgeToFreqList) {
        if (ageWhenWidowed['ageWhenWidowed'] == ageWhenWidowedInYears) {
          ageWhenWidowed['count']++;
          ageWhenWidowedMatchFound = true;
          break;
        }
      }

      if (lgaMatchFound == false) {
        lgasToFreqList.add({'lga': widowLga, 'count': 1});
      }
      if (employmentStatusMatchFound == false) {
        employmentStatusToFreqList
            .add({'employmentStatus': employmentStatus, 'count': 1});
      }
      if (ngoMembershipStatusMatchFound == false) {
        ngoAffiliationToFreqList
            .add({'affliationStatus': ngoMembershipStatus, 'count': 1});
      }
      if (occupationMatchFound == false) {
        occupationTypeToFreqList.add({'occupation': occupation, 'count': 1});
      }
      if (ageWhenWidowedMatchFound == false) {
        widowedAgeToFreqList
            .add({'ageWhenWidowed': ageWhenWidowedInYears, 'count': 1});
      }
    }

    widowedAgeToFreqList
        .sort((a, b) => a['ageWhenWidowed'].compareTo(b['ageWhenWidowed']));

    // Final asignments
    widowCount = lgasToFreqList.fold<int>(
        0, (previousValue, element) => previousValue + element['count'] as int);
    lgaCount = lgasToFreqList.length;
    lgaData = [...lgasToFreqList];
    employmentStatusData = [...employmentStatusToFreqList];
    ngoAffiliationData = [...ngoAffiliationToFreqList];
    occupationData = [...occupationTypeToFreqList];
    ageWhenWidowedData = [...widowedAgeToFreqList];
  }

  static int getAgeWhenWidowed(Map<String, dynamic> widowData) {
    final DateTime dateWidowed = DateTime.parse(
        formatToDateTimeAcceptable(widowData['husbandBereavementDate']));
    final DateTime dateOfBirth = DateTime.parse(widowData['dob']);
    final Duration ageWhenWidowedDuration = dateWidowed.difference(dateOfBirth);
    return DateTime(0, 0, ageWhenWidowedDuration.inDays).year;
  }
}
