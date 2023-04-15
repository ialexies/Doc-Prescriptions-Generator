import 'dart:developer';
import 'package:client_repository/prescription_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum AddClientStatus { initial, loading, success, failure }

class ClientController extends GetxController {
  ///Call an instance of ClientRepository
  final clientRepository = Get.find<ClientRepository>();

  /// Client textfield controller
  final clientFirstNameController = TextEditingController();
  final clientLastNameController = TextEditingController();
  final clientContactNameController = TextEditingController();

  /// Use for temporary list of med prescription when adding
  final editPrescriptionList = <PrescriptionModel>[].obs;

  /// Fields for client info form when adding and updating
  final clientFirstNameEdit = ''.obs;
  final clientLastNameEdit = ''.obs;
  final clientContactNameEdit = ''.obs;

  /// Fields for the form in dialog when
  /// adding new med in prescription
  final addMedDrugName = ''.obs;
  final addMedDossage = ''.obs;
  final addMedDetails = ''.obs;

  final addClientStatus = AddClientStatus.initial.obs;

  /// Clear and reset forms for updating and deleting client
  void clearAddProfileVals() {
    clientContactNameEdit.value = '';
    clientLastNameEdit.value = '';
    clientContactNameEdit.value = '';
    clientContactNameController.text = '';
    clientFirstNameController.text = '';
    clientLastNameController.text = '';
  }

  /// Add new med in list of prescription
  void addMedInPrescription({required PrescriptionModel toAdd}) {
    editPrescriptionList.add(
      toAdd,
    );
    update();
    clearNewDrugValues();
  }

  /// Edit specific med in the list
  void editMedInPrescription(int forEditIndex) {
    editPrescriptionList[forEditIndex] = PrescriptionModel(
      drugName: addMedDrugName.value,
      details: addMedDetails.value,
      dossage: addMedDossage.value,
    );
  }

  /// Clear data in fields after adding
  void clearNewDrugValues() {
    addMedDrugName.value = '';
    addMedDossage.value = '';
    addMedDetails.value = '';
  }

  /// Checks if all input in drug form is valid
  bool isValidForAddMed() {
    return addMedDetails.value == '' ||
        addMedDrugName.value == '' ||
        addMedDossage.value == '';
  }

  /// Remove specific med in the list
  void removeDrugFromPrescription(PrescriptionModel med) {
    editPrescriptionList.remove(med);
  }

  /// Checks if the inputs for adding New Client are valid
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

  /// Adds new client and upload to firebase
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

  /// Get Details about scpecific client
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

  /// Use Faker and create dummy data for testing
  void addStartingData() => clientRepository.addStartingClients();

  /// Delete All Client docs in firebase
  void deleteDummyData() => clientRepository.deleteDummyData();
}
