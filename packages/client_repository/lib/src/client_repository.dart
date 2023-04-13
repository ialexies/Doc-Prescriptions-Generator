/// {@template client_repository}
/// client repository
/// {@endtemplate}
///
///

// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:client_repository/prescription_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
class ClientRepository {
  /// {@macro client_repository}
  ClientRepository(this.firebaseAuth);

  ///
  FirebaseAuth firebaseAuth;

  /// query for client collection from cloud firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> clients() =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .snapshots();

  ///
  Stream<DocumentSnapshot<Map<String, dynamic>>> clientColDetails(
    String selectedClientId,
  ) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .doc(selectedClientId)
          .snapshots();

  ///
  void addClient({
    required String clientFirstName,
    required String clientLastName,
    required String contact,
    required List<PrescriptionModel> prescription,
  }) {
    final prescriptionJson =
        prescription.map((e) => PrescriptionModel().modelToMap(e)).toList();

    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .doc()
          .set({
        'clientFirstName': clientFirstName,
        'clientLastName': clientLastName,
        'contact': contact,
        'prescription': prescriptionJson
      });
    } catch (e) {
      log('error in clientrepo addclient $e');
      throw ClientRepositoryFailure(
        message: '$e',
      );
    }
  }
}
