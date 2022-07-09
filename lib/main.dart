import 'package:budget_management_system/pages/add_name.dart';
//import 'package:budget_management_system/pages/homepage.dart';
import 'package:budget_management_system/pages/splash.dart';
import 'package:budget_management_system/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';


void main() async{
  await Hive.initFlutter();
  await Hive.openBox("Money");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget Manager',
      theme: myTheme,
      home: const Splash(),
    );
  }
}

