import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:prescription_repository/prescription_repository.dart';

Future<void> initializeRepositories() async {
  log('Initializing Repositories: ');

  Get
    ..put(
      AuthRepository(
          firebaseAuth: FirebaseAuth.instance,
          firebaseFirestore: FirebaseFirestore.instance),
    )
    ..put(
      PrescriptionRepository(),
    );

  log('Repositories Inititalized!');
}
