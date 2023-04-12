import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_prescriptions/app/modules/prescription/controllers/prescription_controller.dart';
import 'package:doc_prescriptions/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prescription_repository/prescription_repository.dart';

class PrescriptionView extends GetView<PrescriptionController> {
  const PrescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: controller.prescriptionRepository.prescriptionCol(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            }

            return Builder(
              builder: (context) {
                if (!snapshot.hasData) const SizedBox.shrink();
                return ListView(
                  padding: const EdgeInsets.all(15),
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    if (document.data() == null) const SizedBox.shrink();
                    final data = document.data()! as Map<String, dynamic>;
                    final dataSerialized = ClientModel.fromMap(data);
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListTile(
                        title: Text(dataSerialized.clientFirstName ?? ''),
                        subtitle: Text(dataSerialized.contact ?? ''),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            size: 90.sp,
                          ),
                        ),
                        onTap: () => Get.toNamed(
                          Routes.prescriptionDetails,
                          arguments: document.id,
                        ),
                        dense: true,
                        hoverColor: Colors.amber,
                        style: ListTileStyle.drawer,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF2A8068)),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        )
      ],
    );
  }
}
