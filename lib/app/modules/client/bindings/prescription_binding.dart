import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:get/get.dart';

class ClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientController>(
      () {
        return ClientController();
      },
    );
  }
}
