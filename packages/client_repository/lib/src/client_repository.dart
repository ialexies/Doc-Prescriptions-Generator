/// {@template client_repository}
/// client repository
/// {@endtemplate}
///
///

// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:client_repository/prescription_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
// import 'package:faker/faker.dart';
// import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
class ClientRepository {
  /// {@macro client_repository}
  ClientRepository(this.firebaseAuth);

  ///
  final faker = Faker();

  ///
  FirebaseAuth firebaseAuth;

  /// query for client collection from cloud firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> clients() =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          // .where("clientFirstName", arrayContainsAny:  [])
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

  ///
  Future<void> addStartingClients() async {
    final db = FirebaseFirestore.instance;

    var drugList = [
      'Alaxan',
      'Biogesic',
      'Medicol',
      'Cefelexin',
      'Gardan',
      'Rubitusin',
      'Diatabs',
      'Decolgen',
      'Aspirin',
      'Mefinamic',
      'Neozep',
    ];
    var drugDossageList = [
      '150ml',
      '300ml',
      '500mg',
      '250mg',
      '500mg',
    ];

    for (var i = 0; i <= 3; i++) {
      final documentsToAdd = {
        'clientFirstName': faker.person.firstName(),
        'clientLastName': faker.person.lastName(),
        'contact': '09${faker.phoneNumber.random.fromCharSet('0123456789', 9)}',
        'prescription': [
          {
            'drugName': (drugList..shuffle()).first,
            'dossage': (drugDossageList..shuffle()).first,
            'details': 'After Breakfast, once a day'
          },
          {
            'drugName': (drugList..shuffle()).first,
            'dossage': (drugDossageList..shuffle()).first,
            'details': 'After Breakfast, once a day'
          },
          {
            'drugName': (drugList..shuffle()).first,
            'dossage': (drugDossageList..shuffle()).first,
            'details': 'After Breakfast, once a day'
          },
          {
            'drugName': (drugList..shuffle()).first,
            'dossage': '${(drugDossageList..shuffle()).first}ml',
            'details': 'After Breakfast, once a day'
          },
        ]
      };
      await db
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          // .doc(doc['id'].toString())
          .doc(faker.phoneNumber.random.fromCharSet('0123456789', 9).toString())
          .set(documentsToAdd)
          .then((_) => print('Document  successfully written!'))
          .catchError((error) => print('Error writing document $error'));
    }

    // for (final doc in documentsToAdd) {
    //   await db
    //       .collection('users')
    //       .doc(firebaseAuth.currentUser?.uid ?? '')
    //       .collection('prescriptions')
    //       // .doc(doc['id'].toString())
    //       .doc(faker.hashCode.toString())
    //       .set(doc['data'] as Map<String, dynamic>)
    //       .then((_) => print('Document ${doc['id']} successfully written!'))
    //       .catchError(
    //           (error) => print('Error writing document ${doc['id']}: $error'));
    // }
  }

  ///
  Future<void> deleteClient({required String uid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .doc(uid)
          .delete();
    } catch (e) {
      log(e.toString());
    }
  }

  ///
  Future<void> existingClientEditPrescriptionDetails({
    required String clientId,
    required int currIndex,
    List<PrescriptionModel>? prescriptionList,
    required List<PrescriptionModel> updatedPrescriptionList,
  }) async {
    final prescriptionJson = updatedPrescriptionList
        .map((e) => PrescriptionModel().modelToMap(e))
        .toList();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .doc(clientId)
          .update({'prescription': prescriptionJson});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteDummyData() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc().delete();
      // .doc(firebaseAuth.currentUser?.uid ?? '')
      // .delete();
      // .collection('prescriptions').
    } catch (e) {
      log(e.toString());
    }
  }
}
