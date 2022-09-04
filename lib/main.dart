import 'package:flutter/material.dart';
import 'package:frivia/home.dart';
import 'package:frivia/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily:'ArchitectsDaughter' ,
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
        primarySwatch: Colors.blue,
      ),
      home: const StartGame(),//GamePage()
    );
  }

}
