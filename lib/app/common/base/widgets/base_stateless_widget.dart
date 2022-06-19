import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseStateless<C extends GetxController> extends StatelessWidget {
  String? tag;

  BaseStateless({Key? key}) : super(key: key);

  C get controller => GetInstance().find<C>(tag: tag);

  Widget onBuilder(BuildContext context) => const SizedBox();

  final String? page = null;

  @override
  Widget build(BuildContext context) {
    return onBuilder(context);
  }
}
