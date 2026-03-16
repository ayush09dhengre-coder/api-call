import 'package:flutter/material.dart';
import 'package:profiledata/home_page.dart';
import 'package:profiledata/login_page.dart';
import 'package:profiledata/screens/response.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color(0xFF1A237E)),
      ),
      home:  LoginPage(),
      //HomePage(
      //   emailPath: "",
      //   namePath: "",
      //   numberPath: "",
      //   newPath: "",
      // )
    );
  }
}