///CLIENT REPOSITORY
// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:client_repository/prescription_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';

///
class ClientRepository {
  /// Constructor
  ClientRepository(this.firebaseAuth);

  /// Initialize Faker
  final faker = Faker();

  /// Initialize firebase Authentication
  FirebaseAuth firebaseAuth;

  /// query for client collection from cloud firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> clients() =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          // .where("clientFirstName", arrayContainsAny:  [])
          .snapshots();

  /// Get Details about specific Client
  Stream<DocumentSnapshot<Map<String, dynamic>>> clientColDetails(
    String selectedClientId,
  ) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .doc(selectedClientId)
          .snapshots();

  /// Add Client and upload to firebase
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

  /// Create a dummy data  for testing
  Future<void> addStartingClients() async {
    final db = FirebaseFirestore.instance;
    final clientRepoConst = ClientRepoConst();
    for (var i = 0; i <= 3; i++) {
      final documentsToAdd = {
        'clientFirstName': faker.person.firstName(),
        'clientLastName': faker.person.lastName(),
        'contact': '09${faker.phoneNumber.random.fromCharSet('0123456789', 9)}',
        'prescription': [
          {
            'drugName': (clientRepoConst.drugList..shuffle()).first,
            'dossage': (clientRepoConst.drugDossageList..shuffle()).first,
            'details': 'After Breakfast, once a day'
          },
          {
            'drugName': (clientRepoConst.drugList..shuffle()).first,
            'dossage': (clientRepoConst.drugDossageList..shuffle()).first,
            'details': 'After Breakfast, once a day'
          },
          {
            'drugName': (clientRepoConst.drugList..shuffle()).first,
            'dossage': (clientRepoConst.drugDossageList..shuffle()).first,
            'details': 'After Breakfast, once a day'
          },
          {
            'drugName': (clientRepoConst.drugList..shuffle()).first,
            'dossage':
                '${(clientRepoConst.drugDossageList..shuffle()).first}ml',
            'details': 'After Breakfast, once a day'
          },
        ]
      };
      await db
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .doc(faker.phoneNumber.random.fromCharSet('0123456789', 9).toString())
          .set(documentsToAdd)
          .then((_) => print('Document  successfully written!'))
          .catchError((error) => print('Error writing document $error'));
    }
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

  /// Delete All Dummy Data
  Future<void> deleteDummyData() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc().delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
