import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_widget/models/user_school_info.dart';
import 'package:school_widget/screens/settings/grade_class.dart';
import 'package:school_widget/screens/settings/school.dart';
import 'package:school_widget/services/fetch_timetable.dart';
import 'package:school_widget/util/widget_service.dart';
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
  UserSchoolInfo _school = UserSchoolInfo(
    SCHUL_NM: "",
    SD_SCHUL_CODE: "",
    ATPT_OFCDC_SC_CODE: "",
    LCTN_SC_NM: "",
    ORG_RDNMA: "",
    SCHUL_KND_SC_NM: "",
  );

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

      String? savedData = _prefs.getString('user_school_info');

      if (savedData != null) {
        _school = UserSchoolInfo.fromJson(jsonDecode(savedData));
      }
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
                ).then((_) {
                  setState(() {
                    initPrefs();
                  });
                });
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
                ).then((_) {
                  setState(() {
                    initPrefs();
                  });
                });
              },
            ),
            Text('학교: ${_school.SCHUL_NM}'),
            Text('학년: $_gradeText'),
            Text('반: $_classText'),
            Text('학교 코드: ${_school.SD_SCHUL_CODE}'),
            ElevatedButton(
              onPressed: () async {
                var timetable = await fetchTimetable(
                  _school.ATPT_OFCDC_SC_CODE,
                  _school.SD_SCHUL_CODE,
                  _gradeText,
                  _classText,
                  schoolTypeMap[_school.SCHUL_KND_SC_NM] ?? 'his',
                );

                await WidgetService.saveData("timetable", timetable);
                await WidgetService.updateWidget(
                  iOSWidgetName: WidgetService.timetableWidgetiOSName,
                  qualifiedAndroidName:
                      WidgetService.timetableWidgetAndroidName,
                );
                // var a = await WidgetService.getData("timetable");
                // print(a);
              },
              child: Text("타임테이블 테스트"),
            ),
          ],
        ),
      ),
    );
  }
}
