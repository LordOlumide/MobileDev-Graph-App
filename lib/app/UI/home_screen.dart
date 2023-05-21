import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/data_repo.dart';
import './ui_helpers/shadows.dart';
// widgets
import 'widgets/components/container_1.dart';
import 'widgets/lga_chart/lga_chart.dart';
import 'widgets/occupation_chart/occupation_chart.dart';
import 'widgets/age_widowed_chart/age_when_widowed_chart.dart';
import 'widgets/employment_status_chart/employment_status_chart.dart';
import 'widgets/ngo_affiliation_chart/ngo_affiliation_chart.dart';
import 'widgets/years_as_widow_chart/years_as_widow_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    DataRepo.initialize();
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: pureWhite,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                customShadow1(
                  dx: 6,
                  dy: 6,
                  blurRadius: 30,
                  opacity: 0.2,
                ),
                customShadow2(
                  dx: 2,
                  dy: 2,
                  blurRadius: 4,
                  opacity: 0.25,
                ),
              ],
            ),
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 40),
            padding: const EdgeInsets.all(25),
            child: FutureBuilder(
              future: DataRepo.file,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    // Section 1 - Total number
                    ShadowedContainer1(
                      image: 'assets/images/blue_wave.png',
                      iconPath: 'assets/svgs/group.svg',
                      headerText: 'TOTAL NUMBER OF WIDOWS REGISTERED',
                      count: snapshot.connectionState == ConnectionState.done
                          ? DataRepo.widowCount
                          : null,
                      iconColor: normalBlue.withOpacity(0.67),
                    ),
                    const SizedBox(height: 24),

                    // Section 2 - Select Local Gov
                    ShadowedContainer1(
                      image: 'assets/images/purple_wave.png',
                      iconPath: 'assets/svgs/person_and_houses.svg',
                      headerText: 'SELECT LOCAL GOVERNMENT',
                      count: snapshot.connectionState == ConnectionState.done
                          ? DataRepo.lgaCount
                          : null,
                      iconColor: deepBlue,
                    ),
                    const SizedBox(height: 32),

                    snapshot.connectionState == ConnectionState.done
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  // Section 3 - number by local gov chart
                                  LGAChart(
                                    lgaRegistrationDataTemp: DataRepo.lgaData,
                                  ),
                                  const SizedBox(height: 16),

                                  // Section 4 - Employment status chart
                                  EmploymentStatusChart(
                                    employmentStatusData:
                                        DataRepo.employmentStatusData,
                                  ),
                                  const SizedBox(height: 16),

                                  // Section 5 - NGO Affiliation chart
                                  NGOAffiliationChart(
                                    ngoAffiliationData:
                                        DataRepo.ngoAffiliationData,
                                  ),
                                  const SizedBox(height: 16),

                                  // Section 6 - Years spent as widow chart
                                  YearsSpentAsWidowChart(
                                      yearsAsWidowDataTemp:
                                          DataRepo.yearsAsWidowData),
                                  const SizedBox(height: 16),

                                  // Section 7 - Widows age at spouse bereavement
                                  AgeWhenWidowedChart(
                                    ageWhenWidowedData:
                                        DataRepo.ageWhenWidowedData,
                                  ),
                                  const SizedBox(height: 16),

                                  // Section 8 - Occupation chart
                                  OccupationChart(
                                    occupationData: DataRepo.occupationData,
                                  )
                                ],
                              ),
                            ],
                          )
                        : CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(deepBlue),
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
