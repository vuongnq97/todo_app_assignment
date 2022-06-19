import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
import 'package:todo_list/app/enums/enums.dart';
import 'package:todo_list/app/modules/home/controller/home_controller.dart';
import 'package:todo_list/app/modules/main/screen/main_page.dart';
import 'package:todo_list/app/modules/main/widget/fab_bottom_app_bar.dart';

class MainController extends GetxController {
  static MainController get to => Get.find<MainController>();
  final HomeController _homeController = Get.find();
  Key? tabParams;
  RxInt currentTabID = RxInt(0);
  RxString titleAppBar = RxString('allTasks'.tr);

  var btAppBarItems = [
    AppBarItem(id: MainTabIndex.home, iconData: Icons.pending, text: 'all'.tr),
    AppBarItem(id: MainTabIndex.completeTask, iconData: Icons.check_circle_outline, text: 'complete'.tr),
    AppBarItem(id: MainTabIndex.inCompleteTask, iconData: Icons.access_time_rounded, text: 'inComplete'.tr),
  ].obs;

  onSelectTabBar(AppBarItem? appBarItem) async {
    switch (appBarItem?.id) {
      case MainTabIndex.home:
        titleAppBar.value = "allTasks".tr;
        currentTabID.value = MainTabIndex.home;
        _homeController.filter(status: TaskStatus.all);
        break;
      case MainTabIndex.completeTask:
        titleAppBar.value = "completeTasks".tr;
        currentTabID.value = MainTabIndex.completeTask;
        _homeController.filter(status: TaskStatus.completed);
        break;
      case MainTabIndex.inCompleteTask:
        titleAppBar.value = "inCompleteTasks".tr;
        currentTabID.value = MainTabIndex.inCompleteTask;
        _homeController.filter(status: TaskStatus.inCompleted);
        break;
    }
  }
}
