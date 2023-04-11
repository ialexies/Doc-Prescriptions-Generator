import 'package:authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final authRepository = Get.find<AuthRepository>();
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

  Future<bool> signOut() async {
    try {
      return await authRepository.signout();
    } catch (e) {
      rethrow;
    }
  }
}
