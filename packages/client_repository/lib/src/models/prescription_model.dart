import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PrescriptionModel {
  String? drugName;
  String? dossage;
  String? details;
  PrescriptionModel({
    this.drugName,
    this.dossage,
    this.details,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'drugName': drugName,
      'dossage': dossage,
      'details': details,
    };
  }

  factory PrescriptionModel.fromMap(Map<String, dynamic> map) {
    return PrescriptionModel(
      drugName: map['drugName'] != null ? map['drugName'] as String : '',
      dossage: map['dossage'] != null ? map['dossage'] as String : '',
      details: map['details'] != null ? map['details'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PrescriptionModel.fromJson(String source) =>
      PrescriptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
