import 'package:flutter/material.dart';
import 'package:rick_and_morty/css/colors.dart';
import 'package:rick_and_morty/pages/splash_home.dart';

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
      theme: ThemeData(primaryColor: primaryColor, fontFamily: 'Roboto'),
      home: const SplashHome(),
    );
  }
}
