import 'package:doc_prescriptions/app/modules/home/controllers/home_controller.dart';
import 'package:doc_prescriptions/app/modules/home/widgets/dp_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final PageController pageController = PageController();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> homeViews = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
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
            icon: Icon(Icons.home),
            label: 'Home',
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
