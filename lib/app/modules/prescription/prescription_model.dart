import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Prescription {
  String clientLastName;
  String clientFirstName;
  String contact;
  String medicine;
  String description;
  Prescription({
    required this.clientLastName,
    required this.clientFirstName,
    required this.contact,
    required this.medicine,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientLastName': clientLastName,
      'clientFirstName': clientFirstName,
      'contact': contact,
      'medicine': medicine,
      'description': description,
    };
  }

  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
      clientLastName: map['clientLastName'] as String,
      clientFirstName: map['clientFirstName'] as String,
      contact: map['contact'] as String,
      medicine: map['medicine'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Prescription.fromJson(String source) =>
      Prescription.fromMap(json.decode(source) as Map<String, dynamic>);
}
