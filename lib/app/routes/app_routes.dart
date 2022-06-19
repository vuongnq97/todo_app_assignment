import 'package:get/get.dart';

//
import 'package:todo_list/app/modules/home/binding/home_binding.dart';
import 'package:todo_list/app/modules/main/binding/main_binding.dart';
import 'package:todo_list/app/modules/main/screen/main_page.dart';
import 'package:todo_list/app/modules/splash/binding/splash_binding.dart';
import 'package:todo_list/app/modules/splash/screen/splash_page.dart';

abstract class Routes {
  static const splash = '/';
  static const home = '/home';
  static const main = '/main';
}

abstract class PAGES {
  static const splash = "splash";
  static const home = "home";
  static const main = "main";
}

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.main,
      page: () => MainPage(),
      bindings: [HomeBinding(), MainBinding()],
    ),
  ];
}
