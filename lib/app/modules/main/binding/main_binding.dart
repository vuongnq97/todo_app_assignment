import 'package:get/get.dart';
import 'package:todo_list/app/modules/main/controller/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}
