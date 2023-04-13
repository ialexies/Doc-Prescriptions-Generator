// ignore_for_file: lines_longer_than_80_chars

import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientAddView extends GetView<ClientController> {
  ClientAddView({super.key});

  @override
  final controller = Get.find<ClientController>();

  final docPrecTextFieldDecor = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    filled: true,
    hintStyle: TextStyle(color: Colors.grey[800]),
    hintText: '',
    fillColor: Colors.white70,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Client'),
      ),
      bottomSheet: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: ElevatedButton(
              onPressed: controller.isValidForAddClient()
                  ? null
                  : () {
                      controller.addClient();
                      Get.back();
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                  40,
                ),
              ),
              child: const Text('Add Client '),
            ),
          );
        },
      ),
      // resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: [
                    TextFormField(
                      controller: controller.clientFirstNameController,
                      onChanged: (_) {
                        controller.clientFirstNameEdit.value = _;
                      },
                      decoration: docPrecTextFieldDecor.copyWith(
                        hintText: 'First Name',
                      ),
                    ),
                    TextFormField(
                      controller: controller.clientLastNameController,
                      onChanged: (_) {
                        controller.clientLastNameEdit.value = _;
                      },
                      decoration: docPrecTextFieldDecor.copyWith(
                        hintText: 'Last Name',
                      ),
                    ),
                    TextFormField(
                      controller: controller.clientContactNameController,
                      onChanged: (_) {
                        controller.clientContactNameEdit.value = _;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: docPrecTextFieldDecor.copyWith(
                        hintText: 'Contact',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Prescription',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
              ),
              if (isKeyboardVisible)
                const SizedBox.shrink()
              else
                Expanded(
                  child: Stack(
                    children: [
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            color: Colors.amber[50],
                            border: Border.all(
                              color: Colors.amber.shade800,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(15),
                          child: ListView.separated(
                            itemCount: controller.editPrescriptionList.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              final med =
                                  controller.editPrescriptionList[index];
                              return ListTile(
                                leading: Text(med.dossage ?? ''),
                                title: Text(
                                  med.drugName ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(med.details ?? ''),
                                trailing: IconButton(
                                  onPressed: () {
                                    controller.removeDrugFromPrescription(med);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 0,
                        child: SizedBox(
                          height: 40,
                          child: FloatingActionButton(
                            onPressed: () {
                              // controller.editPrescriptionList.clear();
                              controller.clearNewDrugValues();
                              Get.defaultDialog(
                                title: 'Add Medicine',
                                titlePadding: const EdgeInsets.only(top: 30),
                                content: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Wrap(
                                    runSpacing: 8,
                                    children: [
                                      TextFormField(
                                        onChanged: (_) {
                                          controller.addMedDrugName.value = _;
                                        },
                                        decoration:
                                            docPrecTextFieldDecor.copyWith(
                                          hintText: 'Medicine Name',
                                        ),
                                      ),
                                      TextFormField(
                                        onChanged: (_) {
                                          controller.addMedDossage.value = _;
                                        },
                                        decoration:
                                            docPrecTextFieldDecor.copyWith(
                                          hintText: 'Dossage',
                                        ),
                                      ),
                                      TextFormField(
                                        onChanged: (_) {
                                          controller.addMedDetails.value = _;
                                        },
                                        decoration:
                                            docPrecTextFieldDecor.copyWith(
                                          hintText: 'Details',
                                        ),
                                      ),
                                      Obx(() {
                                        return Column(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size.fromHeight(
                                                  50,
                                                ), // NEW
                                              ),
                                              onPressed:
                                                  controller.isValidForAddMed()
                                                      ? null
                                                      : () {
                                                          controller
                                                              .addMedInPrescription();
                                                          Get.back();
                                                        },
                                              child: const Text('Add'),
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const Icon(Icons.add_task_outlined),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              SizedBox(
                height: 220.h,
              ),
            ],
          );
        },
      ),
    );
  }
}
