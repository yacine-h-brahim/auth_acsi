import 'package:acsi_auth/controllers/email_pwd_regex.dart';
import 'package:acsi_auth/modules/constant/colors.dart';
import 'package:acsi_auth/modules/user.dart';
import 'package:acsi_auth/secret/secret.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({required this.user, super.key});
  final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final User tempUser = widget.user;
    Size size = MediaQuery.of(context).size;

    User user = User(
        id: 1,
        email: 'yacine@gmail.com',
        lastname: 'yacine',
        name: 'yaicne',
        password: 'flejoiOIJOI##13£!!323',
        username: 'yacinehb');
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(80.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      hoverColor: lightBlue,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5,
                                color: const Color.fromARGB(255, 126, 87, 218)),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: Color.fromARGB(255, 126, 87, 218)),
                          ),
                        ),
                      ),
                      onTap: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(
                                user: widget.user,
                              ),
                            ));
                      }),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * .4,
                    child: TextFormField(
                        initialValue: tempUser.username,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: lightBlue,
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
                        onChanged: (value) => tempUser.username = value),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: size.width * .4,
                    child: TextFormField(
                        initialValue: tempUser.email,
                        keyboardType: TextInputType.emailAddress,
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
                        onChanged: (value) => tempUser.email = value),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * .4,
                    child: TextFormField(
                        initialValue: tempUser.name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: lightBlue,
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
                        onChanged: (value) => tempUser.name = value),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: size.width * .4,
                    child: TextFormField(
                        initialValue: tempUser.lastname,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: lightBlue,
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
                        onChanged: (value) => tempUser.lastname = value),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                child: InkWell(
                    child: Container(
                      width: size.width * .5,
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 126, 87, 218),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () async {
                      try {
                        if (formKey.currentState!.validate()) {
                          // update user in database
                          final httpsUri = Uri(
                            scheme: 'https',
                            host: ipAddress,
                            path: '/edit_profile',
                          );
                          final headers = {
                            'Content-Type': 'application/json',
                            'Access-Control-Allow-Origin':
                                '*', //'192.168.43.223'
                            // Replace * with the allowed domain or IP address
                            'Access-Control-Allow-Methods': 'POST',
                            'Access-Control-Allow-Headers': 'Content-Type'
                          };
                          final request = await http.put(
                            httpsUri,
                            headers: headers,
                            body: tempUser.toMap(),
                          );
                          if (context.mounted) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                    user: tempUser,
                                  ),
                                ));
                          }

                          // Fluttertoast.showToast(
                          //     msg: 'Your account was updated successfully ^-^',
                          //     gravity: ToastGravity.TOP,
                          //     backgroundColor: Colors.green);
                        }
                      } catch (e) {
                        // Fluttertoast.showToast(
                        //     msg: 'Failed to save changes:\n${e.toString()}',
                        //     gravity: ToastGravity.TOP,
                        //     backgroundColor: Colors.redAccent);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
