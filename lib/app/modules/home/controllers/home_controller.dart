// ignore_for_file: use_setters_to_change_properties

import 'package:authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  final authRepository = Get.find<AuthRepository>();
  final count = 0.obs;
  void increment() => count.value++;
  Rx<int> selectedIndex = 0.obs;

  late VideoPlayerController vidController;

  @override
  void onInit() {
    super.onInit();
    vidController = VideoPlayerController.asset(
      'assets/images/about_bkg.mp4',
    )..initialize().then((_) {
        vidController
          ..play()
          ..setLooping(true);
      });
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Future<bool> signOut() async {
    try {
      return await authRepository.signout();
    } catch (e) {
      rethrow;
    }
  }
}
