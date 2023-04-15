// ignore_for_file: cast_nullable_to_non_nullable, require_trailing_commas

import 'package:client_repository/prescription_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:doc_prescriptions/app/modules/client/helper/client_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ClientDetailsView extends StatefulWidget {
  const ClientDetailsView({super.key});

  @override
  State<ClientDetailsView> createState() => _ClientDetailsViewState();
}

class _ClientDetailsViewState extends State<ClientDetailsView> {
  final selectedClientId = Get.arguments as String;

  final controller = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: controller.clientRepository.clientColDetails(selectedClientId),
        builder: (
          BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.data == null) return const SizedBox.shrink();
          if (snapshot.data!.data() == null) {
            return const SizedBox.shrink();
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final client = ClientModel.fromMap(data);
          return Builder(
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 500.w,
                      child: LottieBuilder.network(
                          'https://assets7.lottiefiles.com/packages/lf20_lflz1yw9.json'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${client.clientFirstName} ${client.clientLastName}'
                          .toUpperCase(),
                      style: TextStyle(
                        fontSize: 80.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFDCEDF8),
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(20),
                        child: Scrollbar(
                          child: ListView.separated(
                            padding: const EdgeInsets.only(top: 30),
                            itemCount: (client.prescription ?? []).length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              final med = client.prescription![index];
                              return ListTile(
                                // leading: Column(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     SizedBox(
                                //       height: 160.sp,
                                //       child: Lottie.network(
                                //         'https://assets1.lottiefiles.com/packages/lf20_rngukoer.json',
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                title: Text(
                                  '${med.dossage ?? ''} - ${med.drugName ?? ''}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(med.details ?? ''),
                                trailing: IconButton(
                                  onPressed: () {
                                    ClientHelpe().newMedDialog(
                                      buttonText: 'Update',
                                      toEditPres: med,
                                      action: () async {
                                        try {
                                          await controller
                                              .existingClientEditPrescriptionDetails(
                                                  clientId: selectedClientId,
                                                  prescriptionList:
                                                      client.prescription,
                                                  currIndex: index);
                                        } catch (e) {
                                          rethrow;
                                        }

                                        // print('fdfd');
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
