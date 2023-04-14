import 'dart:developer';
import 'package:client_repository/prescription_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum AddClientStatus { initial, loading, success, failure }

class ClientController extends GetxController {
  final clientRepository = Get.find<ClientRepository>();

  final clientFirstNameController = TextEditingController();
  final clientLastNameController = TextEditingController();
  final clientContactNameController = TextEditingController();

  final editPrescriptionList = <PrescriptionModel>[].obs;
  final newClient = ClientModel(clientFirstName: 'fdf').obs;

  final clientFirstNameEdit = ''.obs;
  final clientLastNameEdit = ''.obs;
  final clientContactNameEdit = ''.obs;

  final addMedDrugName = ''.obs;
  final addMedDossage = ''.obs;
  final addMedDetails = ''.obs;

  final addClientStatus = AddClientStatus.initial.obs;

  void clearAddProfileVals() {
    clientContactNameEdit.value = '';
    clientLastNameEdit.value = '';
    clientContactNameEdit.value = '';
    clientContactNameController.text = '';
    clientFirstNameController.text = '';
    clientLastNameController.text = '';
  }

  void addMedInPrescription({required PrescriptionModel toAdd}) {
    editPrescriptionList.add(
      toAdd,
    );
    update();

    clearNewDrugValues();
  }

  void editMedInPrescription(int forEditIndex) {
    editPrescriptionList[forEditIndex] = PrescriptionModel(
      drugName: addMedDrugName.value,
      details: addMedDetails.value,
      dossage: addMedDossage.value,
    );
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

  void removeDrugFromPrescription(PrescriptionModel med) {
    editPrescriptionList.remove(med);
  }

  bool isValidForAddClient() {
    final isClientNameEmpty = clientFirstNameEdit.value.isNotEmpty;
    final isClientContactEmpty = clientContactNameEdit.value.isNotEmpty;
    final isAddClientNotLoading =
        addClientStatus.value != AddClientStatus.loading;
    final isPrescriptionEmpty = editPrescriptionList.isNotEmpty;

    final isValid = isClientNameEmpty &&
        isClientContactEmpty &&
        isAddClientNotLoading &&
        isPrescriptionEmpty;

    return isValid;
  }

  void addClient() {
    addClientStatus.value = AddClientStatus.loading;
    try {
      clientRepository.addClient(
        clientFirstName: clientFirstNameEdit.value,
        clientLastName: clientLastNameEdit.value,
        contact: clientContactNameEdit.value,
        prescription: editPrescriptionList,
      );

      editPrescriptionList.value = [];
      clearNewDrugValues();
      clearAddProfileVals();

      addClientStatus.value = AddClientStatus.initial;
    } catch (e) {
      addClientStatus.value = AddClientStatus.initial;
      rethrow;
    }
  }

  Future<void> deleteClient(String id) async {
    try {
      await clientRepository.deleteClient(uid: id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> existingClientEditPrescriptionDetails({
    required String clientId,
    List<PrescriptionModel>? prescriptionList,
    required int currIndex,
  }) async {
    try {
      final updatedPrescriptionList = prescriptionList;

      final newVal = PrescriptionModel(
        drugName: addMedDrugName.value,
        details: addMedDetails.value,
        dossage: addMedDossage.value,
      );

      updatedPrescriptionList![currIndex] = newVal;

      await clientRepository.existingClientEditPrescriptionDetails(
        clientId: clientId,
        currIndex: currIndex,
        updatedPrescriptionList: updatedPrescriptionList,
      );
    } catch (e) {
      rethrow;
    }
  }
}
