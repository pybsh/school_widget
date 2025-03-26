import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:school_widget/util/widget_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColourScreen extends StatefulWidget {
  const ColourScreen({super.key});

  @override
  State<ColourScreen> createState() => _ColourScreenState();
}

class _ColourScreenState extends State<ColourScreen> {
  // create some values
  Color bgPickerColor = Color(0xff1f1e33);
  Color bgCurrentColor = Color(0xff1f1e33);

  Color dtPickerColor = Colors.amber;
  Color dtCurrentColor = Colors.amber;

  Color mtPickerColor = Colors.white;
  Color mtCurrentColor = Colors.white;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();

    Color? loadColorFromPrefs(String key) {
      final hex = _prefs.getString(key);
      if (hex != null && hex.isNotEmpty) {
        return colorFromHex(hex);
      }
      return null;
    }

    final bgColor = loadColorFromPrefs('bgColor');
    if (bgColor != null) {
      setState(() {
        bgCurrentColor = bgColor;
        bgPickerColor = bgColor;
      });
    }

    final dtColor = loadColorFromPrefs('dtColor');
    if (dtColor != null) {
      setState(() {
        dtCurrentColor = dtColor;
        dtPickerColor = dtColor;
      });
    }

    final mtColor = loadColorFromPrefs('mtColor');
    if (mtColor != null) {
      setState(() {
        mtCurrentColor = mtColor;
        mtPickerColor = mtColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // setGradeClass(_gradeController.text, _classController.text);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(),
            Container(
              decoration: BoxDecoration(
                color: bgCurrentColor,
                borderRadius: BorderRadius.circular(24),
              ),
              width: 200,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "날짜 텍스트",
                    style: TextStyle(
                      color: dtCurrentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "메인 텍스트",
                    style: TextStyle(color: mtCurrentColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: ListTile(
                      enableFeedback: false,
                      title: Text("배경 색상 설정"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("배경 색상 변경"),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: bgPickerColor,
                                  onColorChanged: (color) {
                                    setState(() => bgPickerColor = color);
                                  },
                                  paletteType: PaletteType.hueWheel,
                                  enableAlpha: Platform.isAndroid,
                                  hexInputBar: true,
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text('확인'),
                                  onPressed: () {
                                    setState(
                                      () => bgCurrentColor = bgPickerColor,
                                    );
                                    _prefs.setString(
                                      'bgColor',
                                      bgCurrentColor.toHexString(),
                                    );
                                    WidgetService.saveData(
                                      "bgColor",
                                      bgCurrentColor.toHexString(),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
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
                      title: Text("날짜 텍스트 색상 설정"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("날씨 텍스트 색상 변경"),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: dtPickerColor,
                                  onColorChanged: (color) {
                                    setState(() => dtPickerColor = color);
                                  },
                                  paletteType: PaletteType.hueWheel,
                                  enableAlpha: false,
                                  hexInputBar: true,
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text('확인'),
                                  onPressed: () {
                                    setState(
                                      () => dtCurrentColor = dtPickerColor,
                                    );
                                    _prefs.setString(
                                      'dtColor',
                                      dtCurrentColor.toHexString(),
                                    );
                                    WidgetService.saveData(
                                      "dtColor",
                                      dtCurrentColor.toHexString(),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
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
                      title: Text("메인 텍스트 색상 설정"),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("메인 텍스트 색상 변경"),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: mtPickerColor,
                                  onColorChanged: (color) {
                                    setState(() => mtPickerColor = color);
                                  },
                                  paletteType: PaletteType.hueWheel,
                                  enableAlpha: false,
                                  hexInputBar: true,
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: const Text('확인'),
                                  onPressed: () {
                                    setState(
                                      () => mtCurrentColor = mtPickerColor,
                                    );
                                    _prefs.setString(
                                      'mtColor',
                                      mtCurrentColor.toHexString(),
                                    );
                                    WidgetService.saveData(
                                      "mtColor",
                                      mtCurrentColor.toHexString(),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Theme(
                  //   data: ThemeData(
                  //     splashColor: Colors.transparent,
                  //     highlightColor: Colors.transparent,
                  //   ),
                  //   child: ListTile(
                  //     enableFeedback: false,
                  //     title: Text("배경 투명 설정"),
                  //     trailing: Icon(Icons.block, color: Colors.grey),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
