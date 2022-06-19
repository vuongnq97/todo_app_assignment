import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//
import 'package:todo_list/app/common/base/widgets/base_stateless_widget.dart';
import 'package:todo_list/app/data/models/task.dart';
import 'package:todo_list/app/enums/enums.dart';
import 'package:todo_list/app/modules/home/controller/home_controller.dart';
import 'package:todo_list/app/widgets/shadow_box.dart';

class TaskList extends BaseStateless<HomeController> {
  Widget inCompleted(Task task) {
    return InkWell(
      onTap: () {
        task.status = TaskStatus.completed;
        controller.updateTask(task);
      },
      child: Container(
        height: 35.h,
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(width: 2.r, color: Colors.greenAccent),
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget categoryTask(int type) {
    return Container(
      height: 15.h,
      width: 15.h,
      decoration: BoxDecoration(
        color: CategoryTask.home == type ? Colors.red : (CategoryTask.work == type ? Colors.blue : Colors.green),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget taskItem(Task task) {
    return ShadowBox(
      height: 60.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: task.completed
                ? InkWell(
                    onTap: () {
                      task.status = TaskStatus.inCompleted;
                      controller.updateTask(task);
                    },
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.greenAccent,
                      size: 35.h,
                    ),
                  )
                : inCompleted(task),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      categoryTask(task.categoryType!),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(task.title!,  style: TextStyle(fontSize: 16.sp),),
                      )
                    ],
                  ),
                  Text(
                    task.description!,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          return controller.tasks.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  itemCount: controller.tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    Task item = controller.tasks[index];
                    return taskItem(item);
                  },
                )
              : Center(child: Text("noResult".tr));
        },
      ),
    );
  }
}
