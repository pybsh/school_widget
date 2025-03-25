import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<String> fetchMeal(String atptCode, String schoolCode) async {
  final uri = Uri.https("open.neis.go.kr", "/hub/mealServiceDietInfo", {
    'ATPT_OFCDC_SC_CODE': atptCode,
    'SD_SCHUL_CODE': schoolCode,
    'MLSV_YMD': getToday(), // '20240306',
    'type': 'json',
  });
  var meal = '-';

  try {
    final response = await http.get(uri);
    var json = jsonDecode(response.body);
    
    if (json['mealServiceDietInfo'] != null &&
        json['mealServiceDietInfo'][1]['row'] != null) {
      json = json['mealServiceDietInfo'][1]['row'];
      meal = '';

      json.forEach((element) {
        meal += element['DDISH_NM']
            .replaceAll('<br/>', '\n')
            .replaceAll(
              RegExp(r'(\(([0-9]*\.*?)*\))', caseSensitive: true),
              '',
            );
      });
      // print(json);
    }
  } catch (e) {
    print('Error fetching timetable: $e');
  }

  return meal;
}

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyyMMdd');
  return formatter.format(now);
}
