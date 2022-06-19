import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//
import 'package:todo_list/app/common/base/widgets/base_stateless_widget.dart';
import 'package:todo_list/app/constants/app_colors.dart';
import 'package:todo_list/app/modules/home/controller/home_controller.dart';
import 'package:todo_list/app/modules/home/widget/task_filter.dart';
import 'package:todo_list/app/modules/home/widget/task_form.dart';
import 'package:todo_list/app/modules/home/widget/task_list.dart';
import 'package:todo_list/app/routes/app_routes.dart';

class HomePage extends BaseStateless<HomeController> {
  @override
  String? get page => PAGES.home;

  Widget addButton() {
    return GestureDetector(
      key: const Key('add_btn'),
      onTap: () {
        Get.dialog(
          Dialog(
            insetPadding: EdgeInsets.all(10.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                width: Get.width,
                child: TaskForm()),
          ),
          barrierDismissible: true,
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Icon(
          Icons.add,
          size: 50.h,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          border: Border.fromBorderSide(
            BorderSide(width: 2.r, color: Colors.greenAccent),
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget onBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          addButton(),
          TaskFilter(),
          TaskList(),
        ],
      ),
    );
  }
}
