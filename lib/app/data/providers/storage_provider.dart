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

  save(String key, val) {
    box.write(key, val);
  }

  // readCart(name) async {
  //   final response = await box.read('cart');

  //   // final List<Art> cart = [];

  //   // if (response.runtimeType == List<Art>) {
  //   //   return response;
  //   // }

  //   // for (var element in response) {
  //   //   final decoded = jsonDecode(element);

  //   //   if (decoded.runtimeType != Art) {
  //   //     // cart.add(Art.fromStorage(decoded));
  //   //     cart.add(Art.fromStorage(decoded));
  //   //   } else {
  //   //     cart.add(decoded);
  //   //   }
  //   // }

  //   return cart;
  //   // return response;
  // }

  saveCart(key, val) {
    box.write('cart', val);
  }

  removeCart(String key) {
    box.remove(key);
  }

  remove(String key) {
    box.remove(key);
  }
}
