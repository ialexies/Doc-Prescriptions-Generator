import 'package:client_repository/prescription_repository.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ClientController extends GetxController {
  final clientRepository = Get.find<ClientRepository>();

  final rxFormGroup = fb.group(
    {
      'firstName': FormControl<String>(
        value: '',
        validators: [Validators.required],
        asyncValidatorsDebounceTime: 3000,
      ),
      'lastName': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
        ],
        asyncValidatorsDebounceTime: 3000,
      ),
    },
  ).obs;
}
