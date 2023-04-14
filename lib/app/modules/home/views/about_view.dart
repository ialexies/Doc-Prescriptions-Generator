import 'package:doc_prescriptions/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: double.infinity, minHeight: double.infinity),
      child: ColoredBox(
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
    );
  }
}
