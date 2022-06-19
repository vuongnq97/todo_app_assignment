import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/constants/app_colors.dart';
import 'package:todo_list/app/constants/app_style.dart';
import 'package:todo_list/app/widgets/app_image_widget.dart';
class BaseCustomWidgets implements CustomWidgets {
  @override
  void showSnackBar({String title = "", String message = ""}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black45,
      barBlur: 8.0,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void showErrorSnackBar({String title = "", String message = ""}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      barBlur: 10.0,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  @override
  void showSuccessSnackBar({String title = "", String message = ""}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.c48C46A,
      barBlur: 10.0,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      duration: const Duration(seconds: 2),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  @override
  void showSimpleSnackBar({String message = ""}) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(message, style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void showSimpleErrorSnackBar({String message = ""}) {
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error, color: Colors.white),
        messageText: Text(message, style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void showSimpleSuccessSnackBar({String message = ""}) {
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.blue,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void hideLoadingDialog() {
    EasyLoading.dismiss();
  }

  @override
  void showLoadingDialog() {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        backgroundColor: Colors.white38,
      ),
    );
  }

  @override
  void showAlert({
    String title = "Alert",
    TextStyle? titleStyle,
    Widget? content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onCustom,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    String? textCustom,
    Widget? confirm,
    Widget? cancel,
    Widget? custom,
    Color? backgroundColor,
    bool barrierDismissible = true,
    Color? buttonColor,
    String middleText = "",
    TextStyle? middleTextStyle,
    double radius = 20.0,
    List<Widget>? actions,
    WillPopCallback? onWillPop,
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: titleStyle,
      content: content,
      onConfirm: onConfirm,
      onCancel: onCancel,
      onCustom: onCustom,
      cancelTextColor: cancelTextColor,
      confirmTextColor: confirmTextColor,
      textConfirm: textConfirm,
      textCancel: textCancel,
      textCustom: textCustom,
      confirm: confirm,
      cancel: cancel,
      custom: custom,
      backgroundColor: backgroundColor,
      barrierDismissible: barrierDismissible,
      buttonColor: buttonColor,
      middleText: middleText,
      middleTextStyle: middleTextStyle,
      radius: radius,
      actions: actions,
      onWillPop: onWillPop,
    );
  }

  @override
  void showToast({BuildContext? context, String? icon, String text = ""}) {
    FToast fToast;
    fToast = FToast();
    fToast.init(context!);
    fToast.removeCustomToast();
    final Widget toast = Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(39.r),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: AppImageWidget(
                width: 24.w,
                height: 24.w,
                url: icon,
              ),
            ),
          Text(
            text,
            style: AppStyles.styleRegular.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      positionedToastBuilder:(context, child) {
        return Positioned(
          bottom: 80.h,
          left: 90.w,
          right: 90.w,
          child: child,
        );
      } ,
      toastDuration: const Duration(seconds: 2),
    );
  }
}

abstract class CustomWidgets {
  void showSnackBar({String title = "", String message = ""});

  void showErrorSnackBar({String title = "", String message = ""});

  void showSuccessSnackBar({String title = "", String message = ""});

  void showSimpleSnackBar({String message = ""});

  void showSimpleErrorSnackBar({String message = ""});

  void showSimpleSuccessSnackBar({String message = ""});

  void showLoadingDialog();

  void showAlert({
    String title = "Alert",
    TextStyle titleStyle,
    Widget content,
    VoidCallback onConfirm,
    VoidCallback onCancel,
    VoidCallback onCustom,
    Color cancelTextColor,
    Color confirmTextColor,
    String textConfirm,
    String textCancel,
    String textCustom,
    Widget confirm,
    Widget cancel,
    Widget custom,
    Color backgroundColor,
    bool barrierDismissible = true,
    Color buttonColor,
    String middleText = "",
    TextStyle middleTextStyle,
    double radius = 20.0,
    //   ThemeData themeData,
    List<Widget> actions,

    // onWillPop Scope
    WillPopCallback onWillPop,
  });

  void showToast({String? icon, String text = ""});

  void hideLoadingDialog();
}
