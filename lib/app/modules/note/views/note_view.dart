import 'package:doc_prescriptions/app/modules/client/helper/client_helpers.dart';
import 'package:doc_prescriptions/app/modules/note/controllers/note_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NoteView extends GetView<NoteController> {
  const NoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                15,
              ),
              child: Obx(
                () => TextFormField(
                  initialValue: controller.newNote.value,
                  onChanged: (_) => controller.newNote.value = _,
                  decoration: ClientHelpe().docPrecTextFieldDecor.copyWith(
                        hintText: 'Add New Notes',
                        suffixIcon: IconButton(
                          color: Colors.red,
                          onPressed: () => controller.addNote(
                            note: controller.newNote.value,
                          ),
                          icon: const Icon(Icons.note_add),
                        ),
                      ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Note to add';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                ),
              ),
            ),
            Obx(() => Text(controller.newNote.toString())),
            Obx(() => Column(
                  children: controller.notes
                      .map(
                        (element) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          child: ListTile(
                            subtitle: Text(element),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            ),
                            dense: true,
                            hoverColor: Colors.amber,
                            style: ListTileStyle.drawer,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color.fromARGB(
                                  255,
                                  202,
                                  233,
                                  253,
                                ),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )),
            ElevatedButton(
              onPressed: () =>
                  controller.addNote(note: controller.newNote.value),
              child: const Text('Add Notes'),
            ),
            ElevatedButton(
              onPressed: () => controller.readNotes(),
              child: const Text('Read Notes'),
            ),
            ElevatedButton(
              onPressed: () => controller.deleteAllNotes(),
              child: const Text('Delete All Notes'),
            ),
          ],
        ),
      ),
    );
  }
}
