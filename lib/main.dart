import 'package:flutter/material.dart';
import 'package:valentines_day_frames/photoEditing.dart';
import 'package:valentines_day_frames/photoEditing2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buggy Frames',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: photoEditing2(),
    );
  }
}
