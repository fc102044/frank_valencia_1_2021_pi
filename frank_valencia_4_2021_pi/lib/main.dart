import 'package:flutter/material.dart';
import 'package:frank_valencia_4_2021_pi/screens/home_Screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _getHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parcial Frank Camilo Valencia Ortiz',
        home: HomeScreen());
  }

  void _getHome() async {}
}
