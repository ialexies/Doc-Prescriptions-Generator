/// {@template client_repository}
/// client repository
/// {@endtemplate}
///
///
import 'dart:developer';

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
  void addClient() {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .doc()
          .set({
        'clientFirstName': 'Test',
        'clientLastName': 'test surname',
        'contact': '5294565656',
        'prescription': [
          {
            'details': 'fdfdfdf',
            'dossage': '240ml',
            'drugname': 'testmed',
          }
        ]
      });
    } catch (e) {
      log('error in clientrepo addclient ${e}');
    }
  }
}
