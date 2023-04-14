import 'package:doc_prescriptions/app/modules/client/views/client_view.dart';
import 'package:doc_prescriptions/app/modules/home/controllers/home_controller.dart';
import 'package:doc_prescriptions/app/modules/home/widgets/dp_drawer.dart';
import 'package:doc_prescriptions/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final PageController pageController = PageController();
  final ctrl = Get.find<HomeController>();

  static List<Widget> homeViews = <Widget>[
    const ClientView(),
    ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: double.infinity, minHeight: double.infinity),
      child: Container(
        color: Colors.grey.shade500,
        child: Center(
          child: Stack(
            children: [
              GetBuilder<HomeController>(
                init: HomeController(),
                initState: (_) {},
                builder: (_) {
                  return Center(
                    child: _.vidController.value.isInitialized
                        ? VideoPlayer(_.vidController)
                        : Container(),
                  );
                },
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(30),
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  height: 500.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        '(Firbase Auth, FireStore,  \nVery Good Venture, GetX, )',
                      ),
                    ],
                  ),
                ),
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
