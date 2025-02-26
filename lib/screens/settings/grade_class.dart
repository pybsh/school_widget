import 'package:flutter/material.dart';

class GradeClassScreen extends StatefulWidget {
  const GradeClassScreen({super.key});

  @override
  State<GradeClassScreen> createState() => _GradeClassScreenState();
}

class _GradeClassScreenState extends State<GradeClassScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('학년/반 설정'),
            
          ],
        ),
      ),
    );
  }
}
