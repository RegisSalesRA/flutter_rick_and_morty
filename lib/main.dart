import 'package:flutter/material.dart';
import 'package:rick_and_morty/config/colors.dart';
import 'src/base/base_screen_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      theme: ThemeData(primaryColor: primaryColor, fontFamily: 'Poppins'),
      home: const BaseScreenView(),
    );
  }
}
