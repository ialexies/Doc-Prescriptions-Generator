import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/note_controller.dart';

class NoteView extends GetView<NoteController> {
  const NoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'NoteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
