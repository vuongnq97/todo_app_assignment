import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo_list/app/common/base/widgets/base_stateful_widget.dart';
import 'package:todo_list/app/modules/home/controller/home_controller.dart';
import 'package:todo_list/app/modules/main/controller/main_controller.dart';
import 'package:todo_list/app/modules/main/screen/main_page.dart';
import 'package:todo_list/app/widgets/simple_calendar.dart';

class TaskFilter extends BaseStateful {
  @override
  State<StatefulWidget> createState() {
    return TaskFilterState();
  }
}

class TaskFilterState extends BaseState<HomeController, TaskFilter> {
  final MainController _mainController = Get.find();

  @override
  void initState() {
    super.initState();
    controller.calculatePercentCompleted();
  }

  @override
  void didUpdateWidget(TaskFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.calculatePercentCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 5.h, left: 10.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 5.w,
                    color: Colors.blue,
                  ),
                ),
              ),
              child: Text(
                controller.filterDate.value.day == DateTime.now().day ? "today".tr : DateFormat("dd/MM/yyyy").format(controller.filterDate.value),
                style: TextStyle(fontSize: 22.sp),
              ),
            ),
          ),
          SimpleCalender(
            onSelectedDate: (date) {
              controller.filterDate.value = date;
              controller.filter();
            },
          ),
          if (_mainController.currentTabID.value == MainTabIndex.home && controller.tasks.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w),
              child: Text(
                "${controller.countCompletedTasks.value}/${controller.tasks.length} ${'taskCompleted'.tr}",
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          if (_mainController.currentTabID.value == MainTabIndex.home && controller.tasks.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 5.h, bottom: 15.h, left: 10.w),
              child: LinearPercentIndicator(
                width: 250.w,
                lineHeight: 15.h,
                percent: controller.tasks.isNotEmpty ? controller.percentCompleted.value : 0,
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Colors.grey.withOpacity(0.6),
                linearGradient: const LinearGradient(colors: [
                  Colors.blue,
                  Colors.lightBlue,
                ]),
              ),
            ),
        ],
      ),
    );
  }
}
