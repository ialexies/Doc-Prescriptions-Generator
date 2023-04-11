import 'dart:convert';

///
class Prescription {
  ///
  Prescription({
    required this.clientLastName,
    required this.clientFirstName,
    required this.contact,
    required this.medicine,
    required this.description,
  });

  ///
  factory Prescription.fromJson(String source) =>
      Prescription.fromMap(json.decode(source) as Map<String, dynamic>);

  ///
  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
      clientLastName: map['clientLastName'] as String,
      clientFirstName: map['clientFirstName'] as String,
      contact: map['contact'] as String,
      medicine: map['medicine'] as String,
      description: map['description'] as String,
    );
  }

  ///
  String clientLastName;

  ///
  String clientFirstName;

  ///
  String contact;

  ///
  String medicine;

  ///
  String description;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientLastName': clientLastName,
      'clientFirstName': clientFirstName,
      'contact': contact,
      'medicine': medicine,
      'description': description,
    };
  }

  ///
  String toJson() => json.encode(toMap());
}
