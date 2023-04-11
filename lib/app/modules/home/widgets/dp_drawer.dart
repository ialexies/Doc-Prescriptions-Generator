import 'package:doc_prescriptions/app/modules/home/controllers/home_controller.dart';
import 'package:doc_prescriptions/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DPDrawer extends GetView<HomeController> {
  const DPDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: 400.sp,
                child: DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 30.w,
                          ),
                          const Text(
                            'Dashboard',
                          ),
                        ],
                      ),
                      Builder(
                        builder: (context) => IconButton(
                          onPressed: () => Scaffold.of(context).closeDrawer(),
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                  ),
                ),
                title: const Text(
                  'Profile',
                ),
                onTap: () {},
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 30.w,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout,
                    size: 100.sp,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await controller.signOut();
                      Get.snackbar(
                        'Signedout',
                        '',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      await Get.toNamed(Routes.signin);
                    } catch (e) {
                      Get.snackbar('Error', e.toString());
                    }
                  },
                  child: const Text(
                    'Logout',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
