import 'package:flutter/material.dart';
import 'package:school_widget/services/get_school.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  var _schoolSearchQuery = '';
  final _searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  trailing: [Icon(Icons.search)],
                  controller: controller,
                  onTap: null,
                  onChanged: null,
                  onSubmitted: (value) {
                    setState(() {
                      _schoolSearchQuery = value;
                    });
                    controller.openView();
                  },
                );
              },
              viewOnSubmitted: (value) {
                setState(() {
                  _schoolSearchQuery = value;
                });
                _searchController.closeView('');
                _searchController.openView();
              },
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
                              title: Text(suggestions[index].schoolName),
                              subtitle: Text(suggestions[index].address),
                              onTap: () {
                                controller.closeView(
                                  suggestions[index].schoolName,
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
