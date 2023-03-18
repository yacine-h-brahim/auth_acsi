import 'dart:convert';

import 'package:acsi_auth/controllers/email_pwd_regex.dart';
import 'package:acsi_auth/modules/user.dart';
import 'package:acsi_auth/view/home.dart';
import 'package:acsi_auth/view/edit_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../modules/constant/colors.dart';
import 'package:crypto/crypto.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey();
  User user = User();
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            key: formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50, horizontal: 300),
              child: ListView(
                children: [
                  const Text('Create an account',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: lighBlue,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            label: const Text('Username', style: TextStyle())),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required!!';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => user.username = value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: lighBlue,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            label: const Text('Email', style: TextStyle())),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required!!';
                          } else if (!emailValidator(value)) {
                            return 'Not valid email';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => user.email = value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                            suffixIcon: passwordVisible
                                ? IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () => setState(() {
                                          passwordVisible = !passwordVisible;
                                        }))
                                : IconButton(
                                    icon: const Icon(
                                        Icons.visibility_off_rounded),
                                    onPressed: () => setState(() {
                                          passwordVisible = !passwordVisible;
                                        })),
                            filled: true,
                            fillColor: lighBlue,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            label: const Text('Password', style: TextStyle())),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required!!';
                          } else if (!passwordValidator(value)) {
                            return 'Passoword weak, try make it stronger';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => user.password = value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: lighBlue,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            label: const Text('Name', style: TextStyle())),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required!!';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => user.name = value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: lighBlue,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            label: const Text('Last Name', style: TextStyle())),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required!!';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => user.lastname = value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width * .5,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 126, 87, 218),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            var bytes = utf8.encode(user.password!);
                            user.password = md5.convert(bytes).toString();

                            //add user to database
                            final uri = Uri.parse(
                                'http://192.168.43.223:8080/register');

                            final headers = {
                              'Content-Type': 'application/json',
                              'Access-Control-Allow-Origin':
                                  '*', // Replace * with the allowed domain or IP address
                              'Access-Control-Allow-Methods': 'POST',
                              'Access-Control-Allow-Headers': 'Content-Type'
                            };

                            final response = await http.post(uri,
                                body: jsonEncode(user.toMap()),
                                headers: headers);
                            print(response.body.toString());
                            final res = jsonDecode(response.body);
                            if (res['success'] == true) {
                              if (context.mounted) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                        user: user,
                                      ),
                                    ));
                              }

                              Fluttertoast.showToast(
                                  msg: 'your account was created successfully',
                                  gravity: ToastGravity.TOP,
                                  backgroundColor: Colors.green[400]);
                            } else {
                              Fluttertoast.showToast(
                                msg: res['message'].toString(),
                                backgroundColor: Colors.red,
                                gravity: ToastGravity.TOP,
                              );
                            }
                          }
                        } catch (e) {
                          final error = e as Map;
                          Fluttertoast.showToast(
                            msg: error['message'].toString(),
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.TOP,
                          );
                        }
                      }),
                  const SizedBox(height: 8),
                  Align(
                    child: RichText(
                        text: TextSpan(
                            text: 'Already have an account? ',
                            style: const TextStyle(),
                            children: [
                          TextSpan(
                              text: 'Sign in',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 126, 87, 218)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                })
                        ])),
                  ),
                ],
              ),
              // SvgPicture.asset('assets/resetpassword-bro.svg')
            )),
      ),
    );
  }
}
