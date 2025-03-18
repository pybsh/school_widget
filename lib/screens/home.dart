import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_widget/models/user_school_info.dart';
import 'package:school_widget/services/fetch_meal.dart';
import 'package:school_widget/services/fetch_timetable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;

  var _gradeText = '';
  var _classText = '';
  var _timetable = '';
  var _meal = '';

  UserSchoolInfo _school = UserSchoolInfo(
    SCHUL_NM: "- 학교",
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

    String? savedData = _prefs.getString('user_school_info');

    if (savedData != null) {
      _school = UserSchoolInfo.fromJson(jsonDecode(savedData));
    }

    _gradeText = _prefs.getString('grade') ?? '- ';
    _classText = _prefs.getString('class') ?? '- ';

    if (_gradeText == '') _gradeText = '- ';
    if (_classText == '') _classText = '- ';

    _timetable = await fetchTimetable(
      _school.ATPT_OFCDC_SC_CODE,
      _school.SD_SCHUL_CODE,
      _gradeText,
      _classText,
      schoolTypeMap[_school.SCHUL_KND_SC_NM] ?? 'his',
    );

    _meal = await fetchMeal(_school.ATPT_OFCDC_SC_CODE, _school.SD_SCHUL_CODE);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "School Widget",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(_school.SCHUL_NM),
                Text(" $_gradeText학년 $_classText반"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1f1e33),
                  borderRadius: BorderRadius.circular(24),
                ),
                width: 200,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "[${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().day.toString().padLeft(2, '0')}] 시간표🗓️",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _timetable,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1f1e33),
                borderRadius: BorderRadius.circular(24),
              ),
              width: 200,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "[${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().day.toString().padLeft(2, '0')}] 급식🍔",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _meal,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            if (_timetable == '-')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Column(
                  children: [
                    Text("설정에서 학교, 학년, 반을 설정해주세요."),
                    Text("인터넷이 올바르게 연결되어 있는지 확인해주세요."),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
