import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

import '../modules/client/bindings/prescription_binding.dart';
import '../modules/client/views/client_add_view.dart';
import '../modules/client/views/client_details_view.dart';
import '../modules/client/views/client_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/signin/signin_widget.dart';
import '../modules/home/views/home_view.dart';
import '../modules/note/bindings/note_binding.dart';
import '../modules/note/views/note_view.dart';

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
        return const ClientDetailsView();
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
    GetPage(
      name: _Paths.NOTE,
      page: () => const NoteView(),
      binding: NoteBinding(),
    ),
  ];
}
