import 'package:get/get.dart';
import 'package:prescription_repository/prescription_repository.dart';

class PrescriptionController extends GetxController {
  final prescriptionRepository = Get.find<PrescriptionRepository>();
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
}
