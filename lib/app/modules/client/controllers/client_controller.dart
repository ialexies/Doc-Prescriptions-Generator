import 'dart:developer';
import 'dart:ffi';

import 'package:client_repository/prescription_repository.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  final clientRepository = Get.find<ClientRepository>();

  final editPrescriptionList = <PrescriptionModel>[].obs;
  final newClient = ClientModel(clientFirstName: 'fdf').obs;

  final clientFirstNameEdit = ''.obs;
  final clientLastNameEdit = ''.obs;
  final clientContactNameEdit = ''.obs;

  final addMedDrugName = ''.obs;
  final addMedDossage = ''.obs;
  final addMedDetails = ''.obs;

  void addMedInPrescription() {
    editPrescriptionList.add(
      PrescriptionModel(
        drugName: addMedDrugName.value,
        details: addMedDetails.value,
        dossage: addMedDossage.value,
      ),
    );
    update();

    clearNewDrugValues();
  }

  void clearNewDrugValues() {
    addMedDrugName.value = '';
    addMedDossage.value = '';
    addMedDetails.value = '';
    log('added med');
  }

  bool isValidForAddMed() {
    return addMedDetails.value == '' ||
        addMedDrugName.value == '' ||
        addMedDossage.value == '';
  }

  bool isValidForAddClient() {
    return clientFirstNameEdit.value.isEmpty ||
        clientContactNameEdit.value.isEmpty;
  }

  void removeDrugFromPrescription(PrescriptionModel med) {
    editPrescriptionList.remove(med);
  }

  void addClient() {
    clientRepository.addClient();
  }
}
