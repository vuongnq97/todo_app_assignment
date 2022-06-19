import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseStateful extends StatefulWidget {
  const BaseStateful({Key? key}) : super(key: key);
}

abstract class BaseState<C extends GetxController, T extends StatefulWidget> extends State<T> {
  String? tag;

  C get controller => GetInstance().find<C>(tag: tag);

  Widget onBuilder(BuildContext context) => const SizedBox();

  final String? page = null;

  @override
  Widget build(BuildContext context) {
    return onBuilder(context);
  }
}

abstract class BaseStateKeepAlive<C extends GetxController, T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin {
  final String? tag = null;

  C get controller => GetInstance().find<C>(tag: tag);

  final String? page = null;

  @override
  bool get wantKeepAlive => true;
}
