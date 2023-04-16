import 'dart:developer';

import 'package:doc_prescriptions/app/data/providers/storage_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NoteController extends GetxController {
  final storageProvider = StorageProvider();
  final notes = <String>[].obs;
  final newNote = ''.obs;
  @override
  void onInit() async {
    super.onInit();

    await readNotes();
  }

  Future<void> addNote({required String note}) async {
    try {
      notes.add(note);
      // ignore: invalid_use_of_protected_member
      final tempNewNotes = notes.value;
      await storageProvider.save('notes', tempNewNotes);
      await readNotes();
      newNote.value = '';
      log('success adding note');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> readNotes() async {
    try {
      List<String> tempNotes = [];
      final response = await storageProvider.read('notes') as List<dynamic>;

      tempNotes = response.map((e) => e.toString()).toList();

      notes.value = tempNotes;
      // final tempNotes = notes.value = tempnotes2;
      // log(notes.value.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteAllNotes() async {
    await storageProvider.remove('notes');
    notes.clear();
  }
}

class Note {}
