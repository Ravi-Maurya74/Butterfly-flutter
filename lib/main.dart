// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:social_media/pages/loading_page.dart';
import 'package:social_media/pages/login.dart';
import 'package:social_media/pages/signup.dart';
import 'helpers/create_swatch_color.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal
          // createMaterialColor(Color.fromRGBO(253, 182, 134, 1))
          ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }
}
