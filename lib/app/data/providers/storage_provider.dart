// ignore_for_file: always_declare_return_types, type_annotate_public_apis, inference_failure_on_function_return_type

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider extends GetxService {
  static StorageProvider get to => Get.find();
  final GetStorage box = GetStorage();

  Future<StorageProvider> init() async {
    return this;
  }

  dynamic read(String name) {
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
