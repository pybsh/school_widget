import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_widget/models/user_school_info.dart';
import 'package:school_widget/services/fetch_school.dart';
import 'package:school_widget/util/widget_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  var _schoolSearchQuery = '';

  late SharedPreferences _prefs;

  final _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    String? savedData = _prefs.getString('user_school_info');

    if (savedData == null || savedData.isEmpty) {
      _schoolSearchQuery = '';
    } else {
      try {
        var userSchoolInfo = UserSchoolInfo.fromJson(jsonDecode(savedData));
        _schoolSearchQuery = userSchoolInfo.SCHUL_NM;
      } catch (e) {
        _schoolSearchQuery = '';
        debugPrint('JSON parse error: $e');
      }
    }

    _searchController.text = _schoolSearchQuery;
  }

  void setSchoolSearchQuery(String value) {
    setState(() {
      _schoolSearchQuery = value;
    });
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
            setSchoolSearchQuery(_searchController.text);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('학교 검색'),
            SearchAnchor(
              isFullScreen: false,
              searchController: _searchController,
              viewElevation: 0.0,
              viewBackgroundColor: Colors.transparent,
              viewLeading: SizedBox(),
              // viewLeading: IconButton(
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   onPressed: () {
              //     _searchController.closeView(_searchController.text);
              //   },
              //   icon: Icon(Icons.arrow_back_ios_new),
              // ),
              viewTrailing: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    _searchController.closeView('');
                    setSchoolSearchQuery('');
                  },
                  icon: Icon(Icons.close),
                ),
              ],
              builder: (context, controller) {
                return TextField(
                  // elevation: WidgetStateProperty.all(0.0),
                  // trailing: [Icon(Icons.search)],
                  controller: controller,
                  onTap: null,
                  onChanged: null,
                  decoration: InputDecoration(labelText: "학교이름"),
                  onSubmitted: (value) {
                    setSchoolSearchQuery(value);
                    controller.openView();
                  },
                );
              },
              viewOnSubmitted: (value) {
                _searchController.closeView(value);
                setSchoolSearchQuery(value);
                _searchController.openView();
              },
              suggestionsBuilder: (context, controller) {
                return [
                  FutureBuilder<List>(
                    future: fetchSchool(_schoolSearchQuery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: SizedBox());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('오류가 발생했습니다. 인터넷 환경을 확인해주세요.'),
                        );
                      }
                      final suggestions = snapshot.data;
                      if (suggestions == null || suggestions.isEmpty) {
                        return Center(child: Text('검색 결과가 없습니다.'));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: suggestions.length,
                        itemBuilder:
                            (context, index) => ListTile(
                              splashColor: Colors.transparent,
                              title: Text(suggestions[index].SCHUL_NM),
                              subtitle: Text(suggestions[index].ORG_RDNMA),
                              onTap: () {
                                setSchoolSearchQuery(
                                  suggestions[index].SCHUL_NM,
                                );
                                controller.closeView(
                                  suggestions[index].SCHUL_NM,
                                );
                                _prefs.setString(
                                  'user_school_info',
                                  jsonEncode(suggestions[index].toJson()),
                                );
                                WidgetService.saveData(
                                  "user_school_info",
                                  jsonEncode(suggestions[index].toJson()),
                                );
                              },
                            ),
                      );
                    },
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
