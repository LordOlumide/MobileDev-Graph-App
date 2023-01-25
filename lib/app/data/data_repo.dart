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

  /// For section 6
  /// Format: {'yearsAsWidow': 'String', 'count': int}
  static late List<Map<String, dynamic>> yearsAsWidowData;

  /// For section 7
  /// Format: {'ageWhenWidowed': 'String', 'count': int}
  static late List<Map<String, dynamic>> ageWhenWidowedData;

  /// For section 8
  /// Format: {'occupation': 'String', 'count': int}
  static late List<Map<String, dynamic>> occupationData;

  static Future<void> initialize() async {
    file = decodeFileAndCalculateVars();
  }

  static Future<List<Map<String, dynamic>>> decodeFileAndCalculateVars() async {
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
    final List<Map<String, dynamic>> yearsAsWidowToFreqList = [];
    final List<Map<String, dynamic>> widowedAgeToFreqList = [];
    final List<Map<String, dynamic>> occupationTypeToFreqList = [];

    // Loop for extracting the data
    for (Map<String, dynamic> widowData in contents) {
      final String widowLga = widowData['lga'];

      final String employmentStatus = widowData['employmentStatus'];
      final String ngoMembershipStatus = widowData['ngoMembership'];
      final int yearsSpentAsWidow =
          getYearsSpentAsWidow(widowData['husbandBereavementDate']);
      final int ageWhenWidowedInYears = getAgeWhenWidowed(
        husbandBereavementDate: widowData['husbandBereavementDate'],
        dob: widowData['dob'],
      );
      final String occupation = widowData['occupation'] ?? 'Unemployed';

      bool lgaMatchFound = false;
      bool employmentStatusMatchFound = false;
      bool ngoMembershipStatusMatchFound = false;
      bool ageWhenWidowedMatchFound = false;
      bool yearsAsWidowMatchFound = false;
      bool occupationMatchFound = false;

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
      for (Map<String, dynamic> yearsAsWidow in yearsAsWidowToFreqList) {
        if (yearsAsWidow['yearsAsWidow'] == yearsSpentAsWidow) {
          yearsAsWidow['count']++;
          yearsAsWidowMatchFound = true;
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
      for (Map<String, dynamic> occupationType in occupationTypeToFreqList) {
        if (occupationType['occupation'] == occupation) {
          occupationType['count']++;
          occupationMatchFound = true;
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
      if (yearsAsWidowMatchFound == false) {
        yearsAsWidowToFreqList
            .add({'yearsAsWidow': yearsSpentAsWidow, 'count': 1});
      }
      if (ageWhenWidowedMatchFound == false) {
        widowedAgeToFreqList
            .add({'ageWhenWidowed': ageWhenWidowedInYears, 'count': 1});
      }
      if (occupationMatchFound == false) {
        occupationTypeToFreqList.add({'occupation': occupation, 'count': 1});
      }
    }

    // Adjustments
    // To sort yearsAsWidowToFreqList
    yearsAsWidowToFreqList
        .sort((a, b) => a['yearsAsWidow'].compareTo(b['yearsAsWidow']));
    // To sort widowedAgeToFreqList
    widowedAgeToFreqList
        .sort((a, b) => a['ageWhenWidowed'].compareTo(b['ageWhenWidowed']));
    // To combine "Self Employed" and "Self-Employed" in employmentStatusToFreqList
    final List<Map<String, dynamic>> employmentStatusToFreqList2 = [];
    for (Map<String, dynamic> statusToFreq in employmentStatusToFreqList) {
      if ((statusToFreq['employmentStatus'] != 'Self-Employed') &&
          (statusToFreq['employmentStatus'] != 'Self Employed')) {
        employmentStatusToFreqList2.add(statusToFreq);
      } else {
        bool selfEmployedFound = false;
        for (Map<String, dynamic> i in employmentStatusToFreqList2) {
          if (i['employmentStatus'] == "Self Employed") {
            selfEmployedFound = true;
            i['count'] += statusToFreq['count'];
            break;
          }
        }
        if (selfEmployedFound == false) {
          employmentStatusToFreqList2.add({
            'employmentStatus': "Self Employed",
            'count': statusToFreq['count']
          });
        }
      }
    }

    // Final asignments
    widowCount = lgasToFreqList.fold<int>(
        0, (previousValue, element) => previousValue + element['count'] as int);
    lgaCount = lgasToFreqList.length;
    lgaData = [...lgasToFreqList];
    employmentStatusData = [...employmentStatusToFreqList2];
    ngoAffiliationData = [...ngoAffiliationToFreqList];
    yearsAsWidowData = [...yearsAsWidowToFreqList];
    ageWhenWidowedData = [...widowedAgeToFreqList];
    occupationData = [...occupationTypeToFreqList];
  }

  static int getAgeWhenWidowed({
    required String husbandBereavementDate,
    required String dob,
  }) {
    final DateTime dateWidowed =
        DateTime.parse(formatToDateTimeAcceptable(husbandBereavementDate));
    final DateTime dateOfBirth = DateTime.parse(dob);
    final Duration ageWhenWidowedDuration = dateWidowed.difference(dateOfBirth);
    return DateTime(0, 0, ageWhenWidowedDuration.inDays).year;
  }

  static int getYearsSpentAsWidow(String husbandBereavementDate) {
    final DateTime dateWidowed =
        DateTime.parse(formatToDateTimeAcceptable(husbandBereavementDate));
    final Duration yearsAsWidowDuration =
        DateTime.now().difference(dateWidowed);
    return DateTime(0, 0, yearsAsWidowDuration.inDays).year;
  }
}
