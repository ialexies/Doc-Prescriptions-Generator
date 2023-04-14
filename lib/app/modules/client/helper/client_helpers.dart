// ignore_for_file: inference_failure_on_untyped_parameter, type_annotate_public_apis, avoid_dynamic_calls

import 'package:client_repository/prescription_repository.dart';
import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientHelpe {
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

  void newMedDialog({
    required action,
    PrescriptionModel? toEditPres,
    String? buttonText,
  }) {
    controller.clearNewDrugValues();

    if (toEditPres != null) {
      controller.addMedDrugName.value = toEditPres.drugName ?? '';
      controller.addMedDossage.value = toEditPres.dossage ?? '';
      controller.addMedDetails.value = toEditPres.details ?? '';
    }

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
              initialValue: controller.addMedDrugName.value,
              decoration: docPrecTextFieldDecor.copyWith(
                hintText: 'Medicine Name',
              ),
            ),
            TextFormField(
              onChanged: (_) {
                controller.addMedDossage.value = _;
              },
              initialValue: controller.addMedDossage.value,
              decoration: docPrecTextFieldDecor.copyWith(
                hintText: 'Dossage',
              ),
            ),
            TextFormField(
              onChanged: (_) {
                controller.addMedDetails.value = _;
              },
              initialValue: controller.addMedDetails.value,
              decoration: docPrecTextFieldDecor.copyWith(
                hintText: 'Details',
              ),
            ),
            Obx(() {
              return Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                        50,
                      ),
                    ),
                    onPressed: controller.isValidForAddMed()
                        ? null
                        : () {
                            action();

                            Get.back();
                          },
                    child: Text(buttonText ?? ''),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
