// ignore_for_file: cast_nullable_to_non_nullable, require_trailing_commas

import 'package:client_repository/prescription_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrescriptionDetailsView extends StatefulWidget {
  const PrescriptionDetailsView({super.key});

  @override
  State<PrescriptionDetailsView> createState() =>
      _PrescriptionDetailsViewState();
}

class _PrescriptionDetailsViewState extends State<PrescriptionDetailsView> {
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
                    const CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                          'https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg'),
                    ),
                    Text(
                      '${client.clientFirstName} ${client.clientLastName}',
                      style: TextStyle(
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.amber[50],
                            border: Border.all(
                              color: Colors.amber.shade800,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(20),
                        child: Scrollbar(
                          child: ListView.separated(
                            itemCount: (client.prescription ?? []).length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                            itemBuilder: (BuildContext context, int index) {
                              final med = client.prescription![index];
                              return ListTile(
                                leading: Text(med.dossage ?? ''),
                                title: Text(
                                  med.drugName ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
