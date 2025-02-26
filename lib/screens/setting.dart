import 'package:flutter/material.dart';
import 'package:school_widget/screens/settings/grade_class.dart';
import 'package:school_widget/screens/settings/school.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              child: Text("학교 설정"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SchoolScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text("학년/반 설정"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GradeClassScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
