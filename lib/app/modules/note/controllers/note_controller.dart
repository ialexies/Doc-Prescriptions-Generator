import 'dart:developer';

import 'package:doc_prescriptions/app/data/providers/storage_provider.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final notes = <String>[].obs;
  final storageProvider = StorageProvider();
  Future<void> addNote() async {
    try {
      await storageProvider.save('notes', ['Note1' 'Note 2']);

      log('success adding note');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> readNotes() async {
    try {
      final tempnotes = await storageProvider.read('notes') as List<String>;
      notes.value = tempnotes;
      log(notes.value.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}

class Note {}
