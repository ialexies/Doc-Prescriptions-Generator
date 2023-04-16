import 'package:doc_prescriptions/app/modules/note/controllers/note_controller.dart';
import 'package:get/get.dart';

class NoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteController>(
      NoteController.new,
    );
  }
}
