import 'dart:async';
import 'dart:convert';

import 'package:acsi_auth/controllers/search_disease_function.dart';
import 'package:acsi_auth/controllers/search_symptoms_function.dart';
import 'package:acsi_auth/modules/constant/colors.dart';
import 'package:acsi_auth/modules/disease.dart';
import 'package:acsi_auth/view/home.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Diseases extends StatefulWidget {
  const Diseases({super.key});

  @override
  State<Diseases> createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController searchController = TextEditingController();
  List<Disease> allDiseases = <Disease>[];

  List<Disease> diseases = [];
  bool searchWithSymptoms = false;

  Future<void> getDiseases() async {
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*', //'192.168.43.223'
      // Replace * with the allowed domain or IP address
      'Access-Control-Allow-Methods': 'GET',
      'Access-Control-Allow-Headers': 'Content-Type'
    };

    final url = Uri.parse('http://192.168.43.223:8080/fetch_illnesses');
    final response = await http.get(url, headers: headers);

    final res = jsonDecode(response.body)['data'];
    diseases = [];
    for (var diseaseMap in res) {
      allDiseases.add(Disease.fromMap(diseaseMap));
    }
    diseases = allDiseases;
  }

  @override
  void initState() {
    super.initState();
    getDiseases().then((value) => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    diseases.clear();
    allDiseases.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/e-sbitarLogo.svg',
                width: 100,
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Diseases',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    )),
              ),
              InkWell(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    )),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: purple, borderRadius: BorderRadius.circular(12)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                    child: Text(
                      'Log out',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 24),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .4,
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black.withOpacity(.45),
                                ),
                                hintText: 'search for Diseases & Symptoms ....',
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(.45),
                                ),
                                filled: true,
                                fillColor: lightBlue,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'this field is required';
                              } else if (value.length < 2) {
                                return 'please provide a longer text for better search match';
                              } else {
                                return null;
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (mounted && formKey.currentState!.validate()) {
                                // ignore: todo
                                //TODO: switch case depending on the value of symptoms checkBox

                                setState(() {
                                  diseases = searchWithSymptoms
                                      ? searchSymptomsMethod(allDiseases, value)
                                      : searchDiseasesMethod(
                                          allDiseases, value);
                                });
                              }
                            },
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: purple,
                            value: searchWithSymptoms,
                            onChanged: (value) {
                              setState(() {
                                searchWithSymptoms = value!;
                              });
                            },
                          ),
                          const Text(
                            'search by Symptoms',
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text('${diseases.length} diseases'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: diseases.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.blueGrey[200]!, width: 2.5)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Diseases: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                                Text(
                                  diseases[index].name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            const Text(
                              'Symptoms: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: diseases[index].symptoms.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Text(
                                        '${index + 1}. ${diseases[index].symptoms[index].description}:',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          diseases[index].symptoms[index].name),
                                    ],
                                  );
                                },
                              ),
                            )
                          ]),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
