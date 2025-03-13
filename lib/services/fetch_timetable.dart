import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<String> fetchTimetable(
  String atptCode,
  String schoolCode,
  String grade,
  String classNm,
  String type,
) async {
  final uri = Uri.https("open.neis.go.kr", "/hub/${type}Timetable", {
    'key': '67540679170c4a13a7f7608f4ffea8a7',
    'ATPT_OFCDC_SC_CODE': atptCode,
    'SD_SCHUL_CODE': schoolCode,
    'ALL_TI_YMD': getToday(), // '20240306',
    'GRADE': grade,
    'CLASS_NM': classNm,
    'type': 'json',
  });
  var timetable = '-';
  if (grade == '' || classNm == '') {
    return timetable;
  }

  try {
    final response = await http.get(uri);
    var json = jsonDecode(response.body);
    if (json['${type}Timetable'] != null &&
        json['${type}Timetable'][1]['row'] != null) {
      json = json['${type}Timetable'][1]['row'];
      timetable = '';
      json.forEach((element) {
        timetable += "${element['PERIO']}. ${element['ITRT_CNTNT']}\n";
      });
    }
  } catch (e) {
    print('Error fetching timetable: $e');
  }

  return timetable;
}

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyyMMdd');
  return formatter.format(now);
}
