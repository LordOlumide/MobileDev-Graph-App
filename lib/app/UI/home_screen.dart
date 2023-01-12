import 'package:flutter/material.dart';
import '../services/decoder.dart';

// widgets
import 'widgets/custom_container_1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> file;

  @override
  void initState() {
    file = getDecodedFile();
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 40),
            padding: const EdgeInsets.all(33),
            child: FutureBuilder(
              future: file,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Container1(
                      image: 'assets/images/blue_wave.png',
                      iconPath: 'assets/svgs/Group.svg',
                      headerText: 'TOTAL NUMBER OF WIDOWS REGISTERED',
                      count: snapshot.connectionState == ConnectionState.done
                          ? snapshot.data!.length
                          : null,
                    ),
                    const SizedBox(height: 24),
                    Container1(
                      image: 'assets/svgs/person_and_houses.svg',
                      iconPath: 'assets/svgs/Group.svg',
                      headerText: 'SELECT LOCAL GOVERNMENT',
                      count: snapshot.connectionState == ConnectionState.done
                          ? snapshot.data!.length
                          : null,
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
