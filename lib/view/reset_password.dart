import 'package:acsi_auth/controllers/email_pwd_regex.dart';
import 'package:acsi_auth/modules/constant/colors.dart';
import 'package:acsi_auth/secret/secret.dart';
import 'package:acsi_auth/view/home.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formKey = GlobalKey();
  String password = '';
  String confirmPassword = '';
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 300),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Set new password?',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Text(
                    'Your new password must be diffrent to previously used password',
                    style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(137, 112, 112, 112))),
                const SizedBox(height: 15),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * .5,
                  child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: lightBlue,
                          suffixIcon: passwordVisible
                              ? IconButton(
                                  icon: const Icon(Icons.visibility),
                                  onPressed: () => setState(() {
                                        passwordVisible = !passwordVisible;
                                      }))
                              : IconButton(
                                  icon:
                                      const Icon(Icons.visibility_off_rounded),
                                  onPressed: () => setState(() {
                                        passwordVisible = !passwordVisible;
                                      })),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                          label: const Text('Password', style: TextStyle())),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required!!';
                        } else if (!passwordValidator(value)) {
                          return 'password weak, try make it stronger';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => password = value),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  // width: MediaQuery.of(context).size.width * .5,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: lightBlue,
                          suffixIcon: passwordVisible
                              ? IconButton(
                                  icon: const Icon(Icons.visibility),
                                  onPressed: () => setState(() {
                                        passwordVisible = !passwordVisible;
                                      }))
                              : IconButton(
                                  icon:
                                      const Icon(Icons.visibility_off_rounded),
                                  onPressed: () => setState(() {
                                        passwordVisible = !passwordVisible;
                                      })),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                          label: const Text('Confirm password',
                              style: TextStyle())),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'this field is required!!';
                        } else if (!passwordValidator(value)) {
                          return 'password weak, try make it stronger';
                        } else if (password != value) {
                          return 'not match';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) => confirmPassword = value),
                ),
                const SizedBox(height: 15),
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
                              path: 'reset_password',
                              queryParameters: {'password': password});
                          // final response = await http.get(uri);
                        }
                      } catch (e) {
                        // Fluttertoast.showToast(
                        //     msg: e.toString(),
                        //     backgroundColor: Colors.redAccent,
                        //     gravity: ToastGravity.TOP);
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
            ),
          )),
    );
  }
}
