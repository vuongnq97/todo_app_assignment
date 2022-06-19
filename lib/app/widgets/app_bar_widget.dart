import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_list/app/constants/app_colors.dart';
import 'package:todo_list/app/constants/app_style.dart';

AppBar appBar({
  String? title,
  Widget? middleItem,
  Widget? leftItem,
  Widget? rightItem,
  Color? color,
  double? elevation,
}) {
  return AppBar(
    key: const Key('app_bar'),
    backgroundColor: color ?? AppColors.c99ffff,
    toolbarHeight: kToolbarHeight,
    automaticallyImplyLeading: false,
    elevation: elevation,
    flexibleSpace: CustomAppBar(
      title: title,
      middleItem: middleItem,
      rightItem: rightItem,
      leftItem: leftItem ?? const SizedBox(),
      color: color ?? AppColors.c00ffff,
    ),
  );
}

class CustomAppBar extends StatelessWidget {
  final String? title;
  final Widget? leftItem;
  final Widget? rightItem;
  final Widget? middleItem;
  final Color? color;

  const CustomAppBar({required this.title, this.leftItem, this.rightItem, this.middleItem, this.color});

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      color: color,
      padding: EdgeInsets.only(top: statusBarHeight.h),
      height: statusBarHeight.h + kToolbarHeight.h,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: leftItem ?? const SizedBox(),
          ),
          Align(
            child: Center(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  title!,
                  style: AppStyles.styleMedium.copyWith(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: rightItem ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final Function? onPress;
  final Widget? icon;
  final double? aspectRatio;
  final EdgeInsets? padding;

  const AppBarButton({Key? key, this.onPress, this.icon, this.aspectRatio, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPress?.call();
      },
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: padding ?? const EdgeInsets.all(8),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
      ),
      child: icon ?? const SizedBox(),
    );
  }
}
