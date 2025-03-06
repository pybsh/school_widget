import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:school_widget/models/user_school_info.dart';

Future<List> fetchSchool(String query) async {
  final uri = Uri.https("open.neis.go.kr", "/hub/schoolInfo", {
    'SCHUL_NM': query,
    'type': 'json',
  });
  final response = await http.get(uri);
  var json = jsonDecode(response.body);
  var schoolList = [];

  try {
    if (json['schoolInfo'] != null && json['schoolInfo'][1]['row'] != null) {
      json = json['schoolInfo'][1]['row'];
      json.forEach((element) {
        schoolList.add(UserSchoolInfo.fromJson(element));
      });
    }
  } catch (e) {
    print('Error parsing school data: $e');
  }
  
  return schoolList;
}
