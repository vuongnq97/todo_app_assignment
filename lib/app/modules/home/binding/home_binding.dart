import 'package:get/get.dart';
import 'package:todo_list/app/data/providers/task.provider.dart';
import 'package:todo_list/app/data/repository/task.repository.dart';
import 'package:todo_list/app/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ITaskRepository>(TaskRepository(apiClient: TaskProvider()));
    Get.lazyPut(() => HomeController());
  }
}
