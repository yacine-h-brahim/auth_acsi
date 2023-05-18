// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Disease {
  String id;
  String name;
  List<Symptom> symptoms = <Symptom>[];

  Disease({
    required this.id,
    required this.name,
    required this.symptoms,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symptoms': symptoms.map((x) => x.toMap()).toList(),
    };
  }

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      id: map['id'] as String,
      name: map['name'] as String,
      symptoms: List<Symptom>.from(
        (map['symptoms'] as List<Symptom>).map<Symptom>(
          (x) => Symptom.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Disease.fromJson(String source) =>
      Disease.fromMap(json.decode(source) as Map<String, dynamic>);
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
