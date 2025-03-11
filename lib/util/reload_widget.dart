import 'dart:convert';

import 'package:school_widget/models/user_school_info.dart';
import 'package:school_widget/services/fetch_meal.dart';
import 'package:school_widget/services/fetch_timetable.dart';
import 'package:school_widget/util/widget_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> reloadWidget() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var school = UserSchoolInfo(
    SCHUL_NM: "",
    SD_SCHUL_CODE: "",
    ATPT_OFCDC_SC_CODE: "",
    LCTN_SC_NM: "",
    ORG_RDNMA: "",
    SCHUL_KND_SC_NM: "",
  );

  var gradeText = await WidgetService.getData('grade');
  var classText = await WidgetService.getData('class');

  String? savedData = await WidgetService.getData('user_school_info');

  // print(gradeText);
  // print(classText);
  // print(savedData);

  if (savedData != null) {
    school = UserSchoolInfo.fromJson(jsonDecode(savedData));
  }

  var timetable = await fetchTimetable(
    school.ATPT_OFCDC_SC_CODE,
    school.SD_SCHUL_CODE,
    gradeText,
    classText,
    schoolTypeMap[school.SCHUL_KND_SC_NM] ?? 'his',
  );

  var meal = await fetchMeal(school.ATPT_OFCDC_SC_CODE, school.SD_SCHUL_CODE);

  // print('reload school: ${school.SCHUL_NM}');

  await WidgetService.saveData("timetable", timetable);
  await WidgetService.saveData("meal", meal);
  await WidgetService.updateWidget(
    iOSWidgetName: WidgetService.timetableWidgetiOSName,
    qualifiedAndroidName: WidgetService.timetableWidgetAndroidName,
  );
  await WidgetService.updateWidget(
    iOSWidgetName: WidgetService.mealWidgetiOSName,
    qualifiedAndroidName: WidgetService.mealWidgetAndroidName,
  );
}
