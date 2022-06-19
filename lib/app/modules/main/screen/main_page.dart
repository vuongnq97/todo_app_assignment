import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//
import 'package:todo_list/app/common/base/widgets/base_stateless_widget.dart';
import 'package:todo_list/app/constants/app_colors.dart';
import 'package:todo_list/app/modules/home/screen/home_page.dart';
import 'package:todo_list/app/modules/main/controller/main_controller.dart';
import 'package:todo_list/app/modules/main/widget/fab_bottom_app_bar.dart';
import 'package:todo_list/app/widgets/app_bar_widget.dart';

class MainPage extends BaseStateless<MainController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        bottomNavigationBar: AppBottomAppBar(
          height: 60.0.h,
          iconSize: 28.0.w,
          breakIndex: null,
          selectedId: controller.currentTabID.value,
          color: AppColors.c757575,
          items: controller.btAppBarItems,
          backgroundColor: AppColors.c99ffff,
          selectedColor: AppColors.c33ff99,
          onTabSelected: (item) => controller.onSelectTabBar(item),
        ),
        body: HomePage(),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Obx(
        () => SafeArea(
          bottom: false,
          child: appBar(
            title: controller.titleAppBar.value,
          ),
        ),
      ),
    );
  }
}

class MainTabIndex {
  static const int home = 0;
  static const int completeTask = 1;
  static const int inCompleteTask = 2;
}
