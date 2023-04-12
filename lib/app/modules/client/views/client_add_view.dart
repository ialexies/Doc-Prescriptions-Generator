import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:doc_prescriptions/app/modules/widgets/salondart_text_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Client'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.prescriptionAdd),
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ReactiveForm(
              formGroup: controller.rxFormGroup.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ReactiveCustomTextField(
                    labelText: 'First Name',
                    formControlName: 'clientFirstName',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'This field is required',
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z ]')),
                    ],
                  ),
                  ReactiveCustomTextField(
                    labelText: 'Last Name',
                    formControlName: 'clientLastName',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'This field is required',
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z ]')),
                    ],
                  ),
                  ReactiveCustomTextField(
                    labelText: 'Mobile No.',
                    formControlName: 'contact',
                    validationMessages: (control) => {
                      ValidationMessage.required: 'This field is required',
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z ]')),
                    ],
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
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(20),
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
