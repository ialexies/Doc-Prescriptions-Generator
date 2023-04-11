import 'package:get/get.dart';

class PrescriptionController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    print(' PrescriptionController start');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    print(' PrescriptionController ended');
    super.onClose();
  }

  void increment() => count.value++;
}
