import 'package:client_repository/prescription_repository.dart';
import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:doc_prescriptions/app/modules/client/helper/client_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientAddView extends GetView<ClientController> {
  ClientAddView({super.key});

  @override
  final controller = Get.find<ClientController>();

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
                  ? () {
                      controller.addClient();

                      Get.back();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(
                  40,
                ),
              ),
              child: const Text('Add Client'),
            ),
          );
        },
      ),
      // resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Client Info',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                ),
              ),
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
                      decoration: ClientHelpe().docPrecTextFieldDecor.copyWith(
                            hintText: 'First Name',
                          ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                    ),
                    TextFormField(
                      controller: controller.clientLastNameController,
                      onChanged: (_) {
                        controller.clientLastNameEdit.value = _;
                      },
                      decoration: ClientHelpe().docPrecTextFieldDecor.copyWith(
                            hintText: 'Last Name',
                          ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                    ),
                    TextFormField(
                      controller: controller.clientContactNameController,
                      onChanged: (_) {
                        controller.clientContactNameEdit.value = _;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: ClientHelpe().docPrecTextFieldDecor.copyWith(
                            hintText: 'Contact',
                          ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter contact number';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.always,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Prescription',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 60.sp),
                ),
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
                            color: Colors.cyan[50],
                            border: Border.all(
                              color: Colors.cyan.shade200,
                              width: 2,
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
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        final currIndex = controller
                                            .editPrescriptionList
                                            .indexOf(med);
                                        ClientHelpe().newMedDialog(
                                          buttonText: 'Update',
                                          toEditPres: controller
                                              .editPrescriptionList[currIndex],
                                          action: () {
                                            controller.editMedInPrescription(
                                              currIndex,
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller
                                            .removeDrugFromPrescription(med);
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
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
                            onPressed: () => ClientHelpe().newMedDialog(
                              buttonText: 'Add',
                              action: () {
                                controller.addMedInPrescription(
                                  toAdd: PrescriptionModel(
                                    drugName: controller.addMedDrugName.value,
                                    details: controller.addMedDetails.value,
                                    dossage: controller.addMedDossage.value,
                                  ),
                                );
                              },
                            ),
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
