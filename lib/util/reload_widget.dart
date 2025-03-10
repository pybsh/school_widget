import 'dart:convert';

import 'package:school_widget/models/user_school_info.dart';
import 'package:school_widget/services/fetch_meal.dart';
import 'package:school_widget/services/fetch_timetable.dart';
import 'package:school_widget/util/widget_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> reloadTimetableWidget() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var school = UserSchoolInfo(
    SCHUL_NM: "",
    SD_SCHUL_CODE: "",
    ATPT_OFCDC_SC_CODE: "",
    LCTN_SC_NM: "",
    ORG_RDNMA: "",
    SCHUL_KND_SC_NM: "",
  );

  var gradeText = prefs.getString('grade') ?? '지정된 학년이 없습니다.';
  var classText = prefs.getString('class') ?? '지정된 반이 없습니다.';

  String? savedData = prefs.getString('user_school_info');

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

  await WidgetService.saveData("timetable", timetable);
  await WidgetService.updateWidget(
    iOSWidgetName: WidgetService.timetableWidgetiOSName,
    qualifiedAndroidName: WidgetService.timetableWidgetAndroidName,
  );
}

Future<void> reloadMealWidget() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var school = UserSchoolInfo(
    SCHUL_NM: "",
    SD_SCHUL_CODE: "",
    ATPT_OFCDC_SC_CODE: "",
    LCTN_SC_NM: "",
    ORG_RDNMA: "",
    SCHUL_KND_SC_NM: "",
  );

  String? savedData = prefs.getString('user_school_info');

  if (savedData != null) {
    school = UserSchoolInfo.fromJson(jsonDecode(savedData));
  }

  var meal = await fetchMeal(school.ATPT_OFCDC_SC_CODE, school.SD_SCHUL_CODE);

  await WidgetService.saveData("meal", meal);
  await WidgetService.updateWidget(
    iOSWidgetName: WidgetService.mealWidgetiOSName,
    qualifiedAndroidName: WidgetService.mealWidgetAndroidName,
  );
}
