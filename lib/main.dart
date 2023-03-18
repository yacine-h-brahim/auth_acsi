import 'package:acsi_auth/modules/user.dart';
import 'package:acsi_auth/view/edit_profile.dart';
import 'package:acsi_auth/view/forget_password.dart';
import 'package:acsi_auth/view/reset_password.dart';
import 'package:acsi_auth/view/sign_up.dart';
import 'package:flutter/material.dart';

import 'view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User user = User(
        id: 1,
        email: 'yacine@gmail.com',
        lastname: 'yacine',
        name: 'yaicne',
        password: 'flejoiOIJOI##13£!!323',
        username: 'yacinehb');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const Home(),
    );
  }
}
