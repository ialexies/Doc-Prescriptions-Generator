import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:doc_prescriptions/app/modules/widgets/salondart_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: Column(
        children: [
          ReactiveForm(
            formGroup: controller.rxFormGroup.value,
            child: Column(
              children: [
                ReactiveCustomTextField(
                  labelText: 'First Name',
                  formControlName: 'firstName',
                  validationMessages: (control) => {
                    ValidationMessage.required: 'This field is required',
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z ]')),
                  ],
                ),
                ReactiveCustomTextField(
                  labelText: 'Last Name',
                  formControlName: 'lastName',
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
        ],
      ),
    );
  }
}
