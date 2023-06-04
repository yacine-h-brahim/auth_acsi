// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Disease {
  int id;
  String name;
  List<Symptom> symptoms = [];

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
      id: map['id'] as int,
      name: map['name'] as String,
      symptoms: List<Symptom>.from(
        (map['symptoms']).map<Symptom>(
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
  int id;
  String description;
  String name;

  Symptom({
    required this.id,
    required this.description,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'name': name,
    };
  }

  factory Symptom.fromMap(Map<String, dynamic> map) {
    return Symptom(
      id: map['id'] as int,
      description: map['description'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Symptom.fromJson(String source) =>
      Symptom.fromMap(json.decode(source) as Map<String, dynamic>);
}
