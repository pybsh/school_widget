import 'dart:async';

import 'package:home_widget/home_widget.dart';
import 'package:school_widget/util/reload_widget.dart';

@pragma("vm:entry-point")
Future<void> backgroundCallback(Uri? data) async {
  if (data?.host == 'reload') {
    await reloadWidget();
  }
}

class WidgetService {
  /// iOS
  static const iOSWidgetAppGroupId = 'group.me.pybsh';
  static const timetableWidgetiOSName = 'Timetable';
  static const mealWidgetiOSName = 'Meal';

  /// Android
  static const androidPackagePrefix = 'me.pybsh.school_widget';
  static const timetableWidgetAndroidName =
      '$androidPackagePrefix.TimetableWidgetReceiver';
  static const mealWidgetAndroidName =
      '$androidPackagePrefix.MealWidgetReceiver';

  /// Called in main.dart
  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId(iOSWidgetAppGroupId);
    await HomeWidget.registerInteractivityCallback(backgroundCallback);
  }

  /// Save data to Shared Preferences
  static Future<void> saveData<T>(String key, T data) async {
    await HomeWidget.saveWidgetData<T>(key, data);
  }

  /// Retrieve data from Shared Preferences
  static Future<T?> getData<T>(String key) async {
    return await HomeWidget.getWidgetData<T>(key);
  }

  /// Request to update widgets on both iOS and Android
  static Future<void> updateWidget({
    String? iOSWidgetName,
    String? qualifiedAndroidName,
  }) async {
    await HomeWidget.updateWidget(
      name: '${iOSWidgetName}WidgetReceiver',
      iOSName: iOSWidgetName,
      qualifiedAndroidName: qualifiedAndroidName,
    );
  }
}
