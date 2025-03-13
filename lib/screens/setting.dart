import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_widget/models/user_school_info.dart';
import 'package:school_widget/screens/settings/grade_class.dart';
import 'package:school_widget/screens/settings/school.dart';
import 'package:school_widget/services/fetch_meal.dart';
import 'package:school_widget/services/fetch_timetable.dart';
import 'package:school_widget/util/widget_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        centerTitle: false,
        title: Text(
          "School Widget Settings",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ListTile(
              enableFeedback: false,
              title: Text("학교 설정"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SchoolScreen()),
                );
              },
            ),
          ),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ListTile(
              enableFeedback: false,
              title: Text("학년/반 설정"),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GradeClassScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
