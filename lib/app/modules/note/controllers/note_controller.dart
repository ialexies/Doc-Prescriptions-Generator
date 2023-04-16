import 'dart:developer';

import 'package:doc_prescriptions/app/data/providers/storage_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final storageProvider = StorageProvider();
  final notes = <String>[].obs;
  final newNote = ''.obs;
  final newNoteController = TextEditingController().obs;
  @override
  void onInit() async {
    super.onInit();
    await readNotes();
  }

  Future<void> addNote({required String note}) async {
    if (note.isEmpty) return;
    try {
      notes.add(note);
      // ignore: invalid_use_of_protected_member
      final tempNewNotes = notes.value;
      await storageProvider.save('notes', tempNewNotes);
      await readNotes();
      newNote.value = '';
      newNoteController.value.text = '';
      log('success adding note');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> readNotes() async {
    try {
      var tempNotes = <String>[];
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
    try {
      await storageProvider.remove('notes');
      notes.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deteNote({required int noteIndex}) async {
    try {
      List<String> tempNote = notes.value;

      tempNote.removeAt(noteIndex);

      await storageProvider.save('notes', tempNote);
      readNotes();
    } catch (e) {}
  }
}

class Note {}
