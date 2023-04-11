import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_prescriptions/app/modules/home/controllers/home_controller.dart';
import 'package:doc_prescriptions/app/modules/home/widgets/dp_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final PageController pageController = PageController();

  static const List<Widget> homeViews = <Widget>[
    PrescriptionsPage(),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doc Prescriptions'),
        centerTitle: true,
      ),
      drawer: const DPDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: 'Clients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: Colors.amber[800],
        onTap: controller.onItemTapped,
      ),
      body: Obx(() => homeViews.elementAt(controller.selectedIndex.value)),
    );
  }
}

class PrescriptionsPage extends GetView<HomeController> {
  const PrescriptionsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collectionGroup('prescriptions')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                child: Center(child: CircularProgressIndicator.adaptive()),
              );
            }

            return Builder(
              builder: (context) {
                return ListView(
                  padding: const EdgeInsets.all(15),
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    final data = document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListTile(
                        title: Text(data['clientFirstName'].toString()),
                        subtitle: Text(data['contact'].toString()),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            size: 90.sp,
                          ),
                        ),
                        onTap: () => Get.snackbar('title', ''),
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
