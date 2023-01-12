import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../data/data_repo.dart';
import './ui_helpers/shadows.dart';
// widgets
import 'widgets/custom_container_1.dart';
import 'widgets/horiz_bar_chart_1/horiz_bar_chart.dart';

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
                    Container1(
                      image: 'assets/images/blue_wave.png',
                      iconPath: 'assets/svgs/group.svg',
                      headerText: 'TOTAL NUMBER OF WIDOWS REGISTERED',
                      count: snapshot.connectionState == ConnectionState.done
                          ? DataRepo.widowCount
                          : null,
                      iconColor: normalBlue.withOpacity(0.67),
                    ),
                    const SizedBox(height: 24),
                    Container1(
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
                        ? HorizontalBarChartSection1(
                            registrationData: DataRepo.lgaAndWidowCount,
                            barActiveColor: deepBlue,
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
