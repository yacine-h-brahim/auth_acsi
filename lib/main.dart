import 'package:acsi_auth/view/diseases.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth ACSI',
      theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(background: Colors.white)),
      home: const Diseases(),
    );
  }
}
