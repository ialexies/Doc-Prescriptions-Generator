import 'package:doc_prescriptions/app/modules/home/bindings/home_binding.dart';
import 'package:doc_prescriptions/app/modules/home/signin/signin_widget.dart';
import 'package:doc_prescriptions/app/modules/home/views/home_view.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;
  static const providerConfigs = [EmailProviderConfiguration()];
  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.signin,
      page: () {
        return const SignInWidget(providerConfigs: providerConfigs);
      },
    ),
  ];
}
