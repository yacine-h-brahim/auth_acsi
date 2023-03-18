import 'package:acsi_auth/controllers/email_pwd_regex.dart';
import 'package:acsi_auth/secret/secret.dart';
import 'package:acsi_auth/view/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../modules/constant/colors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? email = '';
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 300),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Forget Password?',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                  'No worries, we\'ll send you rest instructions, enter your email and click submit ',
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(137, 112, 112, 112))),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: formKey,
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width * .5,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: 'Enter your email',
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
                      onChanged: (value) => email = value),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                  child: Container(
                    // width: MediaQuery.of(context).size.width * .5,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 126, 87, 218),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () async {
                    try {
                      if (formKey.currentState!.validate()) {
                        final Uri uri = Uri(
                            host: ipAddress,
                            path: '/forgetpassword',
                            queryParameters: {'email': email});
                        // final response = await http.get(uri);
                      }
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: e.toString(),
                          backgroundColor: Colors.redAccent,
                          gravity: ToastGravity.TOP);
                    }
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 126, 87, 218),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ));
                    },
                  ),
                  // const SizedBox(width: 5),
                  const Text('Go back to log in')
                ],
              )
            ],
          )),
    );
  }
}
