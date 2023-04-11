import 'dart:developer';

import 'package:doc_prescriptions/app/app.dart';
import 'package:doc_prescriptions/bootstrap.dart';
import 'package:doc_prescriptions/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'bmart',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // TODO(ialexies): initialize provider here later
  await initServices();
  await bootstrap(() => const App());
}

Future<void> initServices() async {
  log('starting Servicess....');

  // Add my services here later

  log('All Services started');
}
