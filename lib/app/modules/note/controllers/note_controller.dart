// ignore_for_file: invalid_use_of_protected_member, cascade_invocations

import 'dart:developer';
import 'package:doc_prescriptions/app/data/providers/storage_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NoteController extends GetxController {
  final storageProvider = StorageProvider();
  final notes = <String>[].obs;
  final newNote = ''.obs;
  final newNoteController = TextEditingController().obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await readNotes();
  }

  Future<void> addNote({required String note}) async {
    if (note.isEmpty) return;
    try {
      notes.add(note);
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
      final tempNote = notes.value;

      tempNote.removeAt(noteIndex);

      await storageProvider.save('notes', tempNote);
      await readNotes();
    } catch (e) {
      log(e.toString());
    }
  }
}

class Note {}
