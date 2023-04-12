// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:prescription_repository/src/models/prescription_model.dart';

///
class ClientModel {
  ///
  String? clientLastName;

  ///
  String? clientFirstName;

  ///
  String? contact;

  PrescriptionModel? prescription;

  ClientModel({
    this.clientLastName,
    this.clientFirstName,
    this.contact,
    this.prescription,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientLastName': clientLastName,
      'clientFirstName': clientFirstName,
      'contact': contact,
      'prescription': prescription?.toMap(),
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      clientLastName: map['clientLastName'] != null
          ? map['clientLastName'] as String
          : null,
      clientFirstName: map['clientFirstName'] != null
          ? map['clientFirstName'] as String
          : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      prescription: map['prescription'] != null
          ? PrescriptionModel.fromMap(
              map['prescription'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
