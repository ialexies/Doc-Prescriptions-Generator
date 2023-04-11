import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PrescriptionController extends GetxController {
  final prescriptions =
      FirebaseFirestore.instance.collectionGroup('prescriptions').snapshots();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
