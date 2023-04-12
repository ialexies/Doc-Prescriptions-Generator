import 'dart:developer';
import 'package:doc_prescriptions/app/app.dart';
import 'package:doc_prescriptions/bootstrap.dart';
import 'package:doc_prescriptions/firebase_options.dart';
import 'package:doc_prescriptions/initialize_controllers.dart';
import 'package:doc_prescriptions/initialize_repositories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(
    name: 'docPrescriptions',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeRepositories();
  await initializeControllers();
  await bootstrap(() => const App());
}

Future<void> initServices() async {
  log('starting Servicess....');

  // Add my services here later

  log('All Services started');
}
