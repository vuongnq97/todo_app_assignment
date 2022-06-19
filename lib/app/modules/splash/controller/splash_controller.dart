import 'dart:async';
import 'package:get/get.dart';
//
import 'package:todo_list/app/routes/routes.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  @override
  void onInit() {
    super.onInit();
    Future.wait([_directToHomePage()]).then((value) {
      Get.offNamed(Routes.main);
    });
  }

  Future<void> _directToHomePage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }
}
