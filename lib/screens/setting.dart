import 'package:flutter/cupertino.dart';
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
        centerTitle: false,
        title: Text(
          "School Widget Settings",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
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
                  CupertinoPageRoute(
                    builder: (context) => const SchoolScreen(),
                  ),
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
                  CupertinoPageRoute(
                    builder: (context) => const GradeClassScreen(),
                  ),
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0), child: Divider()),
          Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ExpansionTile(
              shape: const Border(),
              enableFeedback: false,
              leading: Icon(Icons.help, color: Colors.grey),
              title: Text("시간표/급식이 안떠요!"),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Text("데이터는 나이스 교육정보 개방 포털에서 가져와요!"),
                      Text("나이스에 정보가 없거나, 학교 정보가 잘못 입력되었을 수 있어요."),
                      Text("학기 초에는 학교 사정에 따라 시간표 데이터가 없을 수 있어요."),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
