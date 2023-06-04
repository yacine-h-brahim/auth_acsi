import 'dart:convert';
import 'package:acsi_auth/controllers/email_pwd_regex.dart';
import 'package:acsi_auth/modules/user.dart';
import 'package:acsi_auth/modules/constant/colors.dart';
import 'package:acsi_auth/view/diseases.dart';
import 'package:acsi_auth/view/edit_profile.dart';
import 'package:acsi_auth/view/forget_password.dart';
import 'package:acsi_auth/view/sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool passwordVisible = false;
  User user = User();
  String? password = '';
  String? email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                'assets/e-sbitarLogo.svg',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Form(
            key: formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 100, horizontal: 300),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome back',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Welcome back! Please enter your details',
                      style: TextStyle(fontWeight: FontWeight.w400)),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: lightBlue,
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
                        onChanged: (value) => email = value),
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
                            fillColor: lightBlue,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12)),
                            label: const Text('Password', style: TextStyle())),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required!!';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) => password = value),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            ///navigate to forget password page (write email )
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPassword()));
                          },
                          child: const Text(
                            'Forget password',
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 87, 218)),
                          )),
                    ],
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
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      onTap: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            ///hash password /////

                            var bytes = utf8.encode(password!);
                            final hashPassword = md5.convert(bytes);

                            final body = json.encode({
                              // "email": "s.meharzi@esi-sba.dz",
                              // "password": "password",
                              'email': email,
//
                              'password': hashPassword.toString()
                            });
                            print(hashPassword.toString());
                            final headers = {
                              'Content-Type': 'application/json',
                              'Access-Control-Allow-Origin':
                                  '*', //'192.168.43.223'
                              // Replace * with the allowed domain or IP address
                              'Access-Control-Allow-Methods': 'POST',
                              'Access-Control-Allow-Headers': 'Content-Type'
                            };
                            final response = await http.post(
                              Uri.parse('http://192.168.43.223:8080/signin'),
                              body: body,
                              headers: headers,
                            );

                            final res = jsonDecode(response.body);

                            if (res['success'] == true) {
                              user = User.fromMap(
                                  jsonDecode(response.body)['data']);
                              if (context.mounted) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Diseases()));
                                // Fluttertoast.showToast(
                                //   msg: 'Sign in successfully',
                                //   backgroundColor: Colors.red,
                                //   gravity: ToastGravity.TOP,
                                // );
                              }
                            } else {
                              // Fluttertoast.showToast(
                              //   msg: res['message'].toString(),
                              //   backgroundColor: Colors.red,
                              //   gravity: ToastGravity.TOP,
                              // );
                            }
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                          // Fluttertoast.showToast(
                          //     msg: e.toString(),
                          //     backgroundColor: Colors.redAccent,
                          //     gravity: ToastGravity.TOP);
                        }
                      }),
                  const SizedBox(height: 8),
                  Align(
                    child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account yet? ',
                            style: const TextStyle(),
                            children: [
                          TextSpan(
                              text: 'Sign Up',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 126, 87, 218)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()),
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
