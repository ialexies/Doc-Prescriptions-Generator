import 'package:doc_prescriptions/app/modules/client/bindings/prescription_binding.dart';
import 'package:doc_prescriptions/app/modules/client/views/client_add_view.dart';
import 'package:doc_prescriptions/app/modules/client/views/client_details_view.dart';
import 'package:doc_prescriptions/app/modules/home/bindings/home_binding.dart';
import 'package:doc_prescriptions/app/modules/home/signin/signin_widget.dart';
import 'package:doc_prescriptions/app/modules/home/views/home_view.dart';
import 'package:doc_prescriptions/app/modules/client/views/client_view.dart';

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
      page: () {
        return HomeView();
      },
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.signin,
      page: () {
        return const SignInWidget(providerConfigs: providerConfigs);
      },
    ),
    GetPage(
      name: _Paths.prescription,
      page: () => const ClientView(),
      binding: ClientBinding(),
    ),
    GetPage(
      name: _Paths.prescriptionDetails,
      page: () {
        return ClientDetailsView();
      },
      binding: ClientBinding(),
    ),
    GetPage(
      name: _Paths.prescriptionAdd,
      page: () {
        return ClientAddView();
      },
      binding: ClientBinding(),
    ),
  ];
}
