import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_prescriptions/app/modules/prescription/controllers/prescription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prescription_repository/prescription_repository.dart';

class PrescriptionDetailsView extends GetView<PrescriptionController> {
  const PrescriptionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doc Prescriptions'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: controller.prescriptionRepository.prescriptionColDetails(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
              if (snapshot.data == null) return const SizedBox.shrink();
              if (snapshot.data!.data() == null) return const SizedBox.shrink();
              // final a = snapshot.data!.data();
              final data = snapshot.data!.data() as Map<String, dynamic>;
              final client = ClientModel.fromMap(data);
              return Builder(
                builder: (context) {
                  return Column(
                    children: [Text(client.prescription?.details ?? '')],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
