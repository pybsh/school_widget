import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradeClassScreen extends StatefulWidget {
  const GradeClassScreen({super.key});

  @override
  State<GradeClassScreen> createState() => _GradeClassScreenState();
}

class _GradeClassScreenState extends State<GradeClassScreen> {
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _classController = TextEditingController();

  late SharedPreferences _prefs;

  var _gradeText = '';
  var _classText = '';

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _gradeText = _prefs.getString('grade') ?? '';
    _classText = _prefs.getString('class') ?? '';
    _gradeController.text = _gradeText;
    _classController.text = _classText;
  }

  void setGradeClass(String g, String c) {
    setState(() {
      _gradeText = g;
      _classText = c;
    });
    _prefs.setString('grade', g);
    _prefs.setString('class', c);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setGradeClass(_gradeController.text, _classController.text);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('학년/반 설정'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _gradeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(labelText: '학년'),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _classController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '반'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
