import 'dart:convert';

class Disease {
  String id;
  String name;
  List<Symptom>? symptoms = <Symptom>[];
  Disease({
    required this.id,
    required this.name,
    this.symptoms,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symptoms': [],
    };
  }

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
        id: map['id'] as String,
        name: map['name'] as String,
        symptoms: <Symptom>[]);
  }
}

class Symptom {
  String id;
  String diseaseId;
  String value;
  Symptom({
    required this.id,
    required this.diseaseId,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'diseaseId': diseaseId,
      'value': value,
    };
  }

  factory Symptom.fromMap(Map<String, dynamic> map) {
    return Symptom(
      id: map['id'] as String,
      diseaseId: map['diseaseId'] as String,
      value: map['value'] as String,
    );
  }
}
