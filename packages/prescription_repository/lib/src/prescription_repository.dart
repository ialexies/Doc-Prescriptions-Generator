/// {@template prescription_repository}
/// prescription repository
/// {@endtemplate}
///
///
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
class PrescriptionRepository {
  /// {@macro prescription_repository}
  PrescriptionRepository(this.firebaseAuth);

  ///
  FirebaseAuth firebaseAuth;

  /// query for prescription collection from cloud firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> prescriptionCol() =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .snapshots();

  ///
  Stream<DocumentSnapshot<Map<String, dynamic>>> prescriptionColDetails(
    String selectedClientId,
  ) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .collection('prescriptions')
          .doc(selectedClientId)
          .snapshots();
}
