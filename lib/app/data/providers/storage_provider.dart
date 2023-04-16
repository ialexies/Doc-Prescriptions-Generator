import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider extends GetxService {
  static StorageProvider get to => Get.find();
  final GetStorage box = GetStorage();

  Future<StorageProvider> init() async {
    return this;
  }

  read(String name) {
    final val = box.read(name);
    return val;
  }

  save(String key, dynamic val) {
    try {
      box.write(key, val);
    } catch (e) {
      rethrow;
    }
  }

  remove(String key) {
    box.remove(key);
  }
}
