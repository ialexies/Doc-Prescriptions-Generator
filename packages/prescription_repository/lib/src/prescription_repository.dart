/// {@template prescription_repository}
/// prescription repository
/// {@endtemplate}
///
///
import 'package:cloud_firestore/cloud_firestore.dart';

///
class PrescriptionRepository {
  /// {@macro prescription_repository}
  PrescriptionRepository();

  /// query for prescription collection from cloud firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> prescriptionCol() =>
      FirebaseFirestore.instance.collectionGroup('prescriptions').snapshots();
}
