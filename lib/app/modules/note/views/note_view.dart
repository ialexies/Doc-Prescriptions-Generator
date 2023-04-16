import 'package:doc_prescriptions/app/modules/client/helper/client_helpers.dart';
import 'package:doc_prescriptions/app/modules/note/controllers/note_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NoteView extends GetView<NoteController> {
  const NoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(
              15,
            ),
            child: Obx(
              () => TextFormField(
                controller: controller.newNoteController.value,
                // initialValue: controller.newNote.value,
                onChanged: (_) => controller.newNote.value = _,
                decoration: ClientHelpe().docPrecTextFieldDecor.copyWith(
                      hintText: 'Add New Notes',
                      suffixIcon: IconButton(
                        color: Colors.amber,
                        onPressed: () {
                          if (controller.newNote.isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Please enter text in the note field',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                          controller.addNote(
                            note: controller.newNote.value,
                          );
                          Get.snackbar(
                            'Success',
                            'Successfully added new notes',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.amber,
                            colorText: Colors.black,
                          );
                        },
                        icon: const Icon(Icons.note_add),
                      ),
                    ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter Note to add';
                //   }
                //   return null;
                // },
                // autovalidateMode: AutovalidateMode.always,
              ),
            ),
          ),
          Obx(
            () => Column(
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
                          onPressed: () {
                            final indx = controller.notes.indexOf(element);
                            controller.deteNote(noteIndex: indx);
                          },
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
            ),
          ),
          Obx(() {
            if (controller.notes.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return ElevatedButton(
                onPressed: () => controller.deleteAllNotes(),
                child: const Text('Delete All Notes'),
              );
            }
          })
        ],
      ),
    );
  }
}
