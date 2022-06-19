import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//
import 'package:todo_list/app/common/base/widgets/base_stateless_widget.dart';
import 'package:todo_list/app/modules/splash/controller/splash_controller.dart';
import 'package:todo_list/app/routes/routes.dart';

class SplashPage extends BaseStateless<SplashController> {
  @override
  String? get page => PAGES.splash;

  @override
  Widget onBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: EdgeInsets.symmetric(
          horizontal: 0.2.sw,
        ),
        child: Center(
          key: Key('logo'),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.fitHeight,
            width: 130.h,
            height: 111.h,
          ),
        ),
      ),
    );
  }
}
