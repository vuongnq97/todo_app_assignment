import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
import 'package:todo_list/app/utils/device_utils.dart';

class ShadowBox extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;
  final double? padding;
  final double? margin;
  final Color? color;

  const ShadowBox({this.child, this.height, this.width, this.padding, this.margin, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin ?? 10),
      padding: EdgeInsets.all(padding ?? 10),
      width: width ?? DeviceUtils.getScaledWidth(context, 1),
      height: height ?? DeviceUtils.getScaledHeight(context, 0.1),
      child: child,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.12),
            offset: Offset(0, 13.w),
            blurRadius: 23.r,
            spreadRadius: 0.0,
          ),
        ],
      ),
    );
  }
}
