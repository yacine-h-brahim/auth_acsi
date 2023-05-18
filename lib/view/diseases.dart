import 'dart:async';
import 'dart:convert';

import 'package:acsi_auth/modules/disease.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:acsi_auth/secret/secret.dart';
import 'package:flutter/material.dart';

class Diseases extends StatefulWidget {
  const Diseases({super.key});

  @override
  State<Diseases> createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController searchController = TextEditingController();

  final List<Symptom> symptoms = <Symptom>[
    Symptom(id: '1', diseaseId: '1', value: 'Fever'),
    Symptom(id: '1', diseaseId: '1', value: 'Cough'),
    Symptom(id: '1', diseaseId: '1', value: 'Sore throat'),
    Symptom(id: '1', diseaseId: '1', value: 'Runny or stuffy nose'),
    Symptom(id: '1', diseaseId: '1', value: 'Muscle or body aches'),
    Symptom(id: '1', diseaseId: '1', value: 'Headaches'),
    Symptom(id: '1', diseaseId: '1', value: 'Fatigue or extreme tiredness'),
    Symptom(id: '1', diseaseId: '1', value: 'Chills'),
    Symptom(
        id: '1',
        diseaseId: '1',
        value: 'Nausea or vomiting (more common in children)'),
    Symptom(
        id: '1', diseaseId: '1', value: 'Diarrhea (more common in children)'),
  ];
  final List<Disease> diseases = [
    Disease(id: '1', name: 'Influenza (Flu)', symptoms: <Symptom>[
      Symptom(id: '1', diseaseId: '1', value: 'Fever'),
      Symptom(id: '1', diseaseId: '1', value: 'Cough'),
      Symptom(id: '1', diseaseId: '1', value: 'Sore throat'),
      Symptom(id: '1', diseaseId: '1', value: 'Runny or stuffy nose'),
      Symptom(id: '1', diseaseId: '1', value: 'Muscle or body aches'),
      Symptom(id: '1', diseaseId: '1', value: 'Headaches'),
      Symptom(id: '1', diseaseId: '1', value: 'Fatigue or extreme tiredness'),
      Symptom(id: '1', diseaseId: '1', value: 'Chills'),
      Symptom(
          id: '1',
          diseaseId: '1',
          value: 'Nausea or vomiting (more common in children)'),
      Symptom(
          id: '1', diseaseId: '1', value: 'Diarrhea (more common in children)'),
    ])
  ];

  //fill symptoms list

  // ignore: todo
  //TODO: NO NEED FOR THIS METHOD FOR NOW 'AHORA in spanish '
  // getSymptoms(String diseasesId) async {
  //   final httpsUri = Uri(
  //     scheme: 'https',
  //     host: ipAddress,
  //     path: '/disease/$diseasesId',
  //   );
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Access-Control-Allow-Origin': '*', //'192.168.43.223'
  //     // Replace * with the allowed domain or IP address
  //     'Access-Control-Allow-Methods': 'Get',
  //     'Access-Control-Allow-Headers': 'Content-Type'
  //   };
  //   await http
  //       .get(
  //     httpsUri,
  //     headers: headers,
  //   )
  //       .then((response) {
  //     for (var symptom in jsonDecode(response.body)['data'].length) {
  //       symptoms.add(Symptom.fromMap(symptom));
  //     }
  //   });

  //   return symptoms;
  // }

  Future<void> getDiseases() async {
    final httpsUri = Uri(
      scheme: 'https',
      host: ipAddress,
      path: '/diseases',
    );
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*', //'192.168.43.223'
      // Replace * with the allowed domain or IP address
      'Access-Control-Allow-Methods': 'GET',
      'Access-Control-Allow-Headers': 'Content-Type'
    };

// ignore: todo
//TODO: swap between setState & then bodies if it doesn't work
    await http
        .get(
      httpsUri,
      headers: headers,
    )
        .then((response) async {
      final res = jsonDecode(response.body)['diseases'];
      for (var diseaseMap in res.length) {
        setState(() {
          diseases.add(Disease.fromMap(diseaseMap));
        });
      }
    });
  }

  Future<void> getDiseasesQuery(String query) async {
    final httpsUri = Uri(
      scheme: 'https',
      host: ipAddress,
      path: '/diseases/$query',
    );
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*', //'192.168.43.223'
      // Replace * with the allowed domain or IP address
      'Access-Control-Allow-Methods': 'GET',
      'Access-Control-Allow-Headers': 'Content-Type'
    };

// ignore: todo
//TODO: swap between setState & then bodies if it doesn't work
    await http
        .get(
      httpsUri,
      headers: headers,
    )
        .then((response) async {
      final res = jsonDecode(response.body)['diseases'];
      for (var diseaseMap in res.length) {
        setState(() {
          diseases.add(Disease.fromMap(diseaseMap));
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDiseases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  const SizedBox(
                    width: 100,
                    height: 100,
                  )
                ],
              ),
              Form(
                key: formKey,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
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
                            fillColor: const Color(0xFF000000).withOpacity(.04),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'this field is required';
                          } else {
                            return null;
                          }
                        },
                        onFieldSubmitted: (value) {
                          if (mounted && formKey.currentState!.validate()) {
                            getDiseasesQuery(value);
                          }
                        },
                      )),
                ),
              ),
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
                                itemCount: symptoms.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                      '${index + 1}. ${symptoms[index].value}');
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
