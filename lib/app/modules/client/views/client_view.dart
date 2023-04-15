// ignore_for_file: inference_failure_on_generic_invocation, cascade_invocations, avoid_dynamic_calls, cast_nullable_to_non_nullable

import 'dart:developer';

import 'package:client_repository/prescription_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_prescriptions/app/modules/client/controllers/client_controller.dart';
import 'package:doc_prescriptions/app/routes/app_pages.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// class ClientView extends GetView<ClientController> {
class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  final controller = Get.find<ClientController>();
  final searchBoxController = TextEditingController();
  String searchText = '';
  bool isSorted = true;

  final randomAvatarList = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
  ];
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: double.infinity,
      ),
      child: ListView(
        // mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration:
                const BoxDecoration(color: Color(0xFFDCEDF8), border: Border()),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: TextFormField(
                controller: searchBoxController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 202, 233, 253),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 202, 233, 253),
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.red),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Lottie.network(
                      'https://assets6.lottiefiles.com/packages/lf20_e2zcy5pu.json',
                      width: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: controller.clientRepository.clients(),
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

                  final documents = snapshot.data!.docs;

                  final filteredDocuments = documents.where((s) {
                    final data = s.data() as Map<String, dynamic>?;
                    if (data == null) return false;

                    final isValidFname = data['clientFirstName']
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase());
                    final isValidLname = data['clientLastName']
                        .toString()
                        .toLowerCase()
                        .contains(searchText.toLowerCase());

                    final isValid = isValidFname || isValidLname;

                    return isValid;
                  }).toList();

                  if (isSorted) {
                    filteredDocuments.sort((a, b) {
                      final thisB = b.data() as Map<String, dynamic>;
                      final thisA = a.data() as Map<String, dynamic>;

                      final r = thisA['clientFirstName']
                          .compareTo(thisB['clientFirstName']);

                      if (r != 0) return r as int;
                      return thisA['clientLastName']
                          .compareTo(thisB['clientLastName']) as int;
                    });
                  }

                  return Stack(
                    children: [
                      Opacity(
                        opacity: .2,
                        child: LottieBuilder.asset(
                          'assets/images/clients_background.json',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Sort By Name',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                child: Switch(
                                  activeColor: Colors.amber,
                                  activeTrackColor: Colors.cyan,
                                  inactiveThumbColor: Colors.blueGrey.shade600,
                                  inactiveTrackColor: Colors.grey.shade400,
                                  splashRadius: 50,
                                  value: isSorted,
                                  onChanged: (value) =>
                                      setState(() => isSorted = value),
                                ),
                              ),
                            ],
                          ),
                          if (documents.isNotEmpty)
                            const SizedBox.shrink()
                          else
                            Column(
                              children: [
                                DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    border: Border(),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 5,
                                    ),
                                    child: ListTile(
                                      title: const Text(
                                        'No Client Found!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: const Text(
                                        'You can use our existing dummy client data. Press this button.',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      minVerticalPadding: 10,
                                      trailing: IconButton(
                                        color: Colors.white,
                                        onPressed: controller.addStartingData,
                                        icon: const Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SingleChildScrollView(
                            child: SizedBox(
                              height: 1700.h,
                              child: ListView(
                                // physics: const AlwaysScrollableScrollPhysics(), // new
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  bottom: 15,
                                ),
                                shrinkWrap: true,
                                children: filteredDocuments
                                    .map((DocumentSnapshot document) {
                                  if (document.data() == null) {
                                    const SizedBox.shrink();
                                  }
                                  final data =
                                      document.data()! as Map<String, dynamic>;
                                  final dataSerialized =
                                      ClientModel.fromMap(data);

                                  return Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: ListTile(
                                      leading: SizedBox(
                                        width: 150.w,
                                        child: ExtendedImage.asset(
                                          (randomAvatarList..shuffle()).first,
                                        ),
                                      ),
                                      title: Text(
                                        '${dataSerialized.clientFirstName ?? ''} ${dataSerialized.clientLastName ?? ''}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      subtitle:
                                          Text(dataSerialized.contact ?? ''),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          await Get.dialog(
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 40,
                                                  ),
                                                  child: DecoratedBox(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        20,
                                                      ),
                                                      child: Material(
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            const Text(
                                                              'Confirm',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            const Text(
                                                              'Are you sure you want to deletethis client?',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            //Buttons
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      foregroundColor:
                                                                          const Color(
                                                                        0xFFFFFFFF,
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .amber,
                                                                      minimumSize:
                                                                          const Size(
                                                                        0,
                                                                        45,
                                                                      ),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          8,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        Get.back,
                                                                    child:
                                                                        const Text(
                                                                      'NO',
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      foregroundColor:
                                                                          const Color(
                                                                        0xFFFFFFFF,
                                                                      ),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .amber,
                                                                      minimumSize:
                                                                          const Size(
                                                                        0,
                                                                        45,
                                                                      ),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          8,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      Get.back();
                                                                      try {
                                                                        await deleteClient(
                                                                          document,
                                                                        );
                                                                      } catch (e) {
                                                                        log(
                                                                          e.toString(),
                                                                        );
                                                                        // Get.back();
                                                                      }
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'YES',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                          // await deleteClient(document);
                                        },
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
                                        side: BorderSide(
                                          color: Color.fromARGB(
                                            255,
                                            202,
                                            233,
                                            253,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> deleteClient(DocumentSnapshot<Object?> document) async {
    try {
      await controller.deleteClient(document.id);
      Get.snackbar(
        'Deleted',
        'Successfully Deleted',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(30),
        duration: const Duration(milliseconds: 1000),
        animationDuration: Duration.zero,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
