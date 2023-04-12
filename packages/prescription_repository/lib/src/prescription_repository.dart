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

  Stream<DocumentSnapshot<Map<String, dynamic>>> prescriptionColDetails() =>
      FirebaseFirestore.instance
          .collection('users')
          .doc('MprfvQYAx6UX2dHrqNsDE9uFesg2')
          .collection('prescriptions')
          .doc('zAQ6O2v31h2rGzBhE0KL')
          .snapshots();

  // .snapshots().where((event) => false);
}
//           .firestore.('zAQ6O2v31h2rGzBhE0KL')
//           .snapshots();
// }
