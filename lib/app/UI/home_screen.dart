import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../data/data_repo.dart';
import './ui_helpers/shadows.dart';
// widgets
import 'widgets/section1_container.dart';
import 'widgets/lga_chart/lga_chart.dart';
import 'widgets/occupation_chart/occupation_chart.dart';

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
                    // Section 1
                    Section1(
                      image: 'assets/images/blue_wave.png',
                      iconPath: 'assets/svgs/group.svg',
                      headerText: 'TOTAL NUMBER OF WIDOWS REGISTERED',
                      count: snapshot.connectionState == ConnectionState.done
                          ? DataRepo.widowCount
                          : null,
                      iconColor: normalBlue.withOpacity(0.67),
                    ),
                    const SizedBox(height: 24),

                    // Section 2
                    Section1(
                      image: 'assets/images/purple_wave.png',
                      iconPath: 'assets/svgs/person_and_houses.svg',
                      headerText: 'SELECT LOCAL GOVERNMENT',
                      count: snapshot.connectionState == ConnectionState.done
                          ? DataRepo.lgaCount
                          : null,
                      iconColor: deepBlue,
                    ),
                    const SizedBox(height: 32),

                    // Section 3 - number by local gov chart
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        snapshot.connectionState == ConnectionState.done
                            ? LGAChart(
                                lgaRegistrationData: DataRepo.lgaData,
                              )
                            : CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(deepBlue),
                              ),
                        const SizedBox(height: 16),
                      ],
                    ),

                    // Section 8 - Occupation chart
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        snapshot.connectionState == ConnectionState.done
                            ? OccupationChart(
                                occupationData: DataRepo.occupationData,
                              )
                            : CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(deepBlue),
                              ),
                      ],
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
