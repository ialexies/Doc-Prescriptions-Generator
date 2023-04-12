import 'dart:developer';
import 'package:doc_prescriptions/app/modules/home/controllers/home_controller.dart';
import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:get/get.dart';

Future<void> initializeControllers() async {
  log('Initializing Repositories: ');

  Get
    ..lazyPut<HomeController>(
      () {
        return HomeController();
      },
    )
    ..lazyPut<ClientController>(
      () {
        return ClientController();
      },
    );

  log('Controllers  Inititalized!');
}
