import 'package:doc_prescriptions/app/modules/client/views/client_view.dart';
import 'package:doc_prescriptions/app/modules/home/controllers/home_controller.dart';
import 'package:doc_prescriptions/app/modules/home/widgets/dp_drawer.dart';
import 'package:doc_prescriptions/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final PageController pageController = PageController();

  static List<Widget> homeViews = <Widget>[
    ClientView(),
    ConstrainedBox(
      constraints:
          BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
      child: Container(
        color: Colors.grey.shade500,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'FLUTTER APP (Firebase + Flutter)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Created By Alexies Iglesia',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '(Firbase Auth, FlutterFire, Very Good Venture, GetX, )',
              ),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Doc Prescriptions'),
          centerTitle: true,
        ),
        drawer: const DPDrawer(),
        floatingActionButton: controller.selectedIndex.value != 0
            ? null
            : FloatingActionButton(
                onPressed: () => Get.toNamed(Routes.prescriptionAdd),
                child: const Icon(Icons.add),
              ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information),
              label: 'Clients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.amber[800],
          onTap: controller.onItemTapped,
        ),
        body: Obx(() => homeViews.elementAt(controller.selectedIndex.value)),
      ),
    );
  }
}
