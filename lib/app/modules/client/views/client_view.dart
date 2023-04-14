// ignore_for_file: inference_failure_on_generic_invocation

import 'dart:developer';

import 'package:client_repository/prescription_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:doc_prescriptions/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientView extends GetView<ClientController> {
  const ClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: controller.clientRepository.clients(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            }

            return Builder(
              builder: (context) {
                if (!snapshot.hasData) const SizedBox.shrink();
                return ListView(
                  padding: const EdgeInsets.all(15),
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    if (document.data() == null) const SizedBox.shrink();
                    final data = document.data()! as Map<String, dynamic>;
                    final dataSerialized = ClientModel.fromMap(data);
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListTile(
                        title: Text(dataSerialized.clientFirstName ?? ''),
                        subtitle: Text(dataSerialized.contact ?? ''),
                        trailing: IconButton(
                          onPressed: () async {
                            await Get.dialog(
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: DecoratedBox(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Material(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Confirm',
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 15),
                                              const Text(
                                                'Are you sure you want to deletethis client?',
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 20),
                                              //Buttons
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            const Color(
                                                          0xFFFFFFFF,
                                                        ),
                                                        backgroundColor:
                                                            Colors.amber,
                                                        minimumSize:
                                                            const Size(0, 45),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      onPressed: Get.back,
                                                      child: const Text(
                                                        'NO',
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            const Color(
                                                          0xFFFFFFFF,
                                                        ),
                                                        backgroundColor:
                                                            Colors.amber,
                                                        minimumSize:
                                                            const Size(0, 45),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        Get.back();
                                                        try {
                                                          await deleteClient(
                                                            document,
                                                          );
                                                        } catch (e) {
                                                          log(e.toString());
                                                          // Get.back();
                                                        }
                                                      },
                                                      child: const Text(
                                                        'YES',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            // await deleteClient(document);
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 90.sp,
                          ),
                        ),
                        onTap: () => Get.toNamed(
                          Routes.prescriptionDetails,
                          arguments: document.id,
                        ),
                        dense: true,
                        hoverColor: Colors.amber,
                        style: ListTileStyle.drawer,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF2A8068)),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        )
      ],
    );
  }

  Future<void> deleteClient(DocumentSnapshot<Object?> document) async {
    try {
      await controller.deleteClient(document.id);
      Get.snackbar(
        'Deleted',
        'Successfully Deleted',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(30),
        duration: const Duration(milliseconds: 1000),
        animationDuration: Duration.zero,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
