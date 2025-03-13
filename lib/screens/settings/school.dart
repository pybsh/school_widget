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
              builder: (context, controller) {
                return SearchBar(
                  // trailing: [Icon(Icons.search)],
                  controller: controller,
                  onTap: null,
                  onChanged: null,
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
              // viewOnSubmitted: (value) {
              //   // setSchoolSearchQuery(value);
              //   _searchController.closeView('');
              //   _searchController.openView();
              // },
              suggestionsBuilder: (context, controller) {
                return [
                  FutureBuilder<List>(
                    future: fetchSchool(_schoolSearchQuery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final suggestions = snapshot.data ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: suggestions.length,
                        itemBuilder:
                            (context, index) => ListTile(
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
