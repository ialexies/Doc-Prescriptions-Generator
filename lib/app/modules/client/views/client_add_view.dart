import 'package:client_repository/prescription_repository.dart';
import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';

import 'package:doc_prescriptions/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ClientAddView extends StatefulWidget {
  const ClientAddView({super.key});

  @override
  State<ClientAddView> createState() => _ClientAddViewState();
}

class _ClientAddViewState extends State<ClientAddView> {
  final controller = Get.find<ClientController>();
  TextEditingController clientFirstNameController = TextEditingController();
  TextEditingController clientLastNameController = TextEditingController();
  TextEditingController clientContactNameController = TextEditingController();
  final docPrecTextFieldDecor = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.defaultDialog(
          //   title: 'Add medicine',
          // );
          controller.newClient.value = ClientModel(
            clientFirstName: controller.clientFirstNameEdit.value,
            clientLastName: controller.clientLastNameEdit.value,
            contact: controller.clientContactNameEdit.value,
            prescription: [],
          );
        },
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Text(controller.newClient.value.clientFirstName.toString()),
            ),
            Obx(
              () => Text(controller.newClient.value.clientLastName.toString()),
            ),
            Obx(
              () => Text(controller.newClient.value.contact.toString()),
            ),
            Obx(
              () => Text(controller.newClient.value.prescription.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  TextFormField(
                    controller: clientFirstNameController,
                    onChanged: (_) {
                      controller.clientFirstNameEdit.value = _;
                    },
                    decoration: docPrecTextFieldDecor.copyWith(
                      hintText: 'First Name',
                    ),
                  ),
                  TextFormField(
                    controller: clientLastNameController,
                    onChanged: (_) {
                      controller.clientLastNameEdit.value = _;
                    },
                    decoration: docPrecTextFieldDecor.copyWith(
                      hintText: 'Last Name',
                    ),
                  ),
                  TextFormField(
                    controller: clientContactNameController,
                    onChanged: (_) {
                      controller.clientContactNameEdit.value = _;
                    },
                    decoration: docPrecTextFieldDecor.copyWith(
                      hintText: 'Contact',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 500.h,
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.editPrescriptionList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  final med = controller.editPrescriptionList[index];
                  return ListTile(
                    leading: Text(med.dossage ?? ''),
                    title: Text(
                      med.drugName ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(med.details ?? ''),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
