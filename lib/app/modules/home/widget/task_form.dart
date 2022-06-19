import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/helper/string_helper.dart';

//
import 'package:todo_list/app/utils/device_utils.dart';
import 'package:todo_list/app/widgets/shadow_box.dart';
import 'package:todo_list/app/enums/enums.dart';
import 'package:todo_list/app/helper/datetime_helper.dart';
import 'package:todo_list/app/common/base/widgets/base_stateful_widget.dart';
import 'package:todo_list/app/modules/home/controller/home_controller.dart';

class TaskForm extends BaseStateful {
  @override
  State<StatefulWidget> createState() {
    return TaskFormState();
  }
}

class TaskFormState extends BaseState<HomeController, TaskForm> {
  final _formKey = GlobalKey<FormState>();
  List<bool> selectedCategories = [true, false, false];
  bool isValidFinishDate = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();

  void onSelectedCategory(int index) {
    if (index == 0) {
      controller.task.categoryType = CategoryTask.home;
      setState(() {
        selectedCategories[0] = true;
        selectedCategories[1] = false;
        selectedCategories[2] = false;
      });
    } else if (index == 1) {
      controller.task.categoryType = CategoryTask.work;
      setState(() {
        selectedCategories[0] = false;
        selectedCategories[1] = true;
        selectedCategories[2] = false;
      });
    } else {
      controller.task.categoryType = CategoryTask.personal;
      setState(() {
        selectedCategories[0] = false;
        selectedCategories[1] = false;
        selectedCategories[2] = true;
      });
    }
  }

  Widget _buildAddButton() {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: InkWell(
        key: const Key('form_add_btn'),
        onTap: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            if (DateTimeHelper.validateDateTime(controller.task.finishYear!, controller.task.finishMonth!, controller.task.finishDay!)) {
              setState(() {
                isValidFinishDate = true;
              });
              controller.onAddTask();
              Navigator.pop(context);
            } else {
              setState(() {
                isValidFinishDate = false;
              });
            }
          }
        },
        child: ShadowBox(
          width: 200.w,
          height: 50.h,
          padding: 0,
          color: Colors.greenAccent,
          child: Center(
            child: Text(
              "addTask".tr,
              style: TextStyle(fontSize: 18.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFinishDate() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.greenAccent,
                size: 30.h,
              ),
              Text(
                "date".tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    key: const Key('task_day'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "required".tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "1",
                      contentPadding: EdgeInsets.all(10.w),
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.task.finishDay = int.parse(value);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    key: const Key('task_month'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "required".tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "1",
                      contentPadding: EdgeInsets.all(10.w),
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.task.finishMonth = int.parse(value);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextFormField(
                    key: const Key('task_year'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "required".tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "2022",
                      contentPadding: EdgeInsets.all(10.w),
                    ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        controller.task.finishYear = int.parse(value);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: !isValidFinishDate,
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                'finishDateError'.tr,
                key: const Key('finish_date_error'),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoriesTask() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w, top: 30.h, bottom: 10.h),
          child: Text("category".tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                onSelectedCategory(0);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20.h),
                height: 75.h,
                width: context.isTablet ? 200 : 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0, 5],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [
                      Colors.redAccent.withOpacity(0.8),
                      Colors.red,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible: selectedCategories[0],
                      child: Icon(
                        Icons.check_outlined,
                        color: Colors.greenAccent,
                        size: 30.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: selectedCategories[0] ? 10.h : 40.h),
                      child: Text(
                        CategoryTask.getName(CategoryTask.home),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                onSelectedCategory(1);
              },
              child: Container(
                margin: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 20.h),
                height: 75.h,
                width: context.isTablet ? 200 : 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0, 5],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [
                      Colors.blueAccent.withOpacity(0.8),
                      Colors.blue,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible: selectedCategories[1],
                      child: Icon(
                        Icons.check_outlined,
                        color: Colors.greenAccent,
                        size: 30.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: selectedCategories[1] ? 10.h : 40.h),
                      child: Text(
                        CategoryTask.getName(CategoryTask.work),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                onSelectedCategory(2);
              },
              child: Container(
                margin: EdgeInsets.only(left: 0.w, right: 0, bottom: 20.h),
                height: 75.h,
                width: context.isTablet ? 200 : 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0, 5],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [
                      Colors.greenAccent.withOpacity(0.8),
                      Colors.green,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible: selectedCategories[2],
                      child: Icon(
                        Icons.check_outlined,
                        color: Colors.greenAccent,
                        size: 30.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: selectedCategories[2] ? 10.h : 40.h),
                      child: Text(
                        CategoryTask.getName(CategoryTask.personal),
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.h,
      key: const Key('addForm'),
      padding: EdgeInsets.all(20.w),
      width: DeviceUtils.getScaledWidth(context, 1),
      child: SingleChildScrollView(
        key: const Key('scroll_form'),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "addTask".tr,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
              ShadowBox(
                height: 80.h,
                margin: 10.w,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: TextFormField(
                    key: const Key('task_title'),
                    controller: titleController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "required".tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.w, bottom: 11.h, top: 11.h, right: 15.w),
                        hintText: "title".tr),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    onChanged: (value) {
                      titleController.text = StringHelper.replaceSpecialChars(value);
                      titleController.selection = TextSelection.fromPosition(TextPosition(offset: titleController.text.length));
                      controller.task.title = StringHelper.replaceSpecialChars(value);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: TextFormField(
                  key: const Key('task_description'),
                  controller: desController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "required".tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.w, bottom: 11.h, top: 11.h, right: 15.w),
                      hintText: "description".tr),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  onChanged: (value) {
                    desController.text = StringHelper.replaceSpecialChars(value);
                    desController.selection = TextSelection.fromPosition(TextPosition(offset: desController.text.length));

                    controller.task.description = value;
                  },
                ),
              ),
              Divider(
                height: 4.h,
                thickness: 1.w,
              ),
              _buildCategoriesTask(),
              _buildFinishDate(),
              _buildAddButton()
            ],
          ),
        ),
      ),
    );
  }
}
