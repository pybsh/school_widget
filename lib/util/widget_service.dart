import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class WidgetService {
  /// iOS
  static const iOSWidgetAppGroupId = 'group.me.pybsh';
  static const timetableWidgetiOSName = 'Timetable';
  static const mealWidgetiOSName = 'Meal';

  /// Android
  static const androidPackagePrefix = 'me.pybsh.school_widget';
  static const timetableWidgetAndroidName =
      '$androidPackagePrefix.receivers.TimetableWidgetReceiver';
  static const mealWidgetAndroidName =
      '$androidPackagePrefix.receivers.MealWidgetReceiver';

  /// Called in main.dart
  static Future<void> initialize() async {
    await HomeWidget.setAppGroupId(iOSWidgetAppGroupId);
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
    final result = await HomeWidget.updateWidget(
      name: iOSWidgetName,
      iOSName: iOSWidgetName,
      qualifiedAndroidName: qualifiedAndroidName,
    );
    debugPrint(
      '[WidgetService.updateWidget] iOSWidgetName: $iOSWidgetName, qualifiedAndroidName: $qualifiedAndroidName, result: $result',
    );
  }
}
