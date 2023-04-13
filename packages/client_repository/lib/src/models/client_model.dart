// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'dart:convert';
import 'package:client_repository/src/models/prescription_model.dart';

///
class ClientModel {
  ///
  String? clientLastName;

  ///
  String? clientFirstName;

  ///
  String? contact;

  List<PrescriptionModel>? prescription;

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
      'prescription': prescription?.map((x) => x.toMap()).toList() ?? {},
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      clientLastName: map['clientLastName'] == null
          ? ''
          : '${(map['clientLastName'] as String)[0].toUpperCase()}${(map['clientLastName'] as String).substring(1).toLowerCase()}',
      clientFirstName: map['clientFirstName'] == null
          ? ''
          : '${(map['clientFirstName'] as String)[0].toUpperCase()}${(map['clientFirstName'] as String).substring(1).toLowerCase()}',
      contact: map['contact'] != null ? map['contact'] as String : '',
      prescription: map['prescription'] == null
          ? []
          : List<PrescriptionModel>.from(
              (map['prescription'] as List<dynamic>).map<PrescriptionModel?>(
                (x) => PrescriptionModel.fromMap(x as Map<String, dynamic>),
              ),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
