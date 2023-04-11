import 'package:doc_prescriptions/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Application',
      // initialRoute: AppPages.initial,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? Routes.signin
          : Routes.home,
      getPages: AppPages.routes,
    );
  }
}
