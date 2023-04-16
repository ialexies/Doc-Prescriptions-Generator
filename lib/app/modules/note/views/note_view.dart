import 'package:doc_prescriptions/app/modules/note/controllers/note_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NoteView extends GetView<NoteController> {
  const NoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Obx(
              () => Column(
                children: controller.notes.map(Text.new).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () => controller.addNote(),
              child: const Text('Add Notes'),
            ),
            ElevatedButton(
              onPressed: () => controller.readNotes(),
              child: const Text('Read Notes'),
            ),
            const Text(
              'NoteView is working',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
