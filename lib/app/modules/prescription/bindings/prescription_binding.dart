import 'package:doc_prescriptions/app/modules/prescription/controllers/prescription_controller.dart';
import 'package:get/get.dart';

class PrescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrescriptionController>(
      () {
        return PrescriptionController();
      },
    );
  }
}
