import 'package:flutter/material.dart';
import 'package:school_widget/screens/settings/grade_class.dart';
import 'package:school_widget/screens/settings/school.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late SharedPreferences _prefs;

  var _gradeText = '';
  var _classText = '';
  var _schoolText = '';

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _gradeText = _prefs.getString('grade') ?? '지정된 학년이 없습니다.';
      _classText = _prefs.getString('class') ?? '지정된 반이 없습니다.';
      _schoolText = _prefs.getString('schoolName') ?? '지정된 학교가 없습니다.';
    });
  }

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
            Text('학교: $_schoolText'),
            Text('학년: $_gradeText'),
            Text('반: $_classText'),
          ],
        ),
      ),
    );
  }
}
