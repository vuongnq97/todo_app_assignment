import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//
import 'package:todo_list/app/constants/app_colors.dart';
import 'package:todo_list/app/constants/app_style.dart';

class AppBarItem {
  int id;
  IconData iconData;
  String text;

  AppBarItem({
    required this.id,
    required this.iconData,
    required this.text,
  });
}

class AppBottomAppBar extends StatefulWidget {
  AppBottomAppBar({
    Key? key,
    required this.items,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    required this.onTabSelected,
    this.selectedId,
    this.breakIndex,
  }) : super(key: key);

  final List<AppBarItem> items;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<AppBarItem?> onTabSelected;
  final int? breakIndex;
  int? selectedId;

  @override
  State<StatefulWidget> createState() => BottomAppBarState();
}

class BottomAppBarState extends State<AppBottomAppBar> {
  void updateIndex(AppBarItem? appBarItem) {
    setState(() {
      widget.selectedId = appBarItem?.id;
    });
    widget.onTabSelected(appBarItem);
  }

  @override
  Widget build(BuildContext context) {
    widget.selectedId ??= widget.items[0].id;
    final List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        onPressed: updateIndex,
      );
    });
    return BottomAppBar(
      shape: widget.notchedShape,
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }

  Widget _buildTabItem({
    required AppBarItem item,
    ValueChanged<AppBarItem?>? onPressed,
  }) {
    final Color? color = widget.selectedId == item.id ? AppColors.c48C46A : AppColors.black;
    final Color? icColor = widget.selectedId == item.id ? AppColors.c48C46A : AppColors.black;
    final Color? backgroundColor = widget.selectedId == item.id ? AppColors.cffff66 : null;
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
        ),
        height: widget.height.h,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            onTap: () => onPressed?.call(item),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.iconData,
                  color: icColor,
                  size: 30.h,
                ),
              //  const SizedBox(height: 10),
                Text(
                  item.text,
                  style: AppStyles.styleMedium.copyWith(
                    color: color,
                    fontSize: 16.sp,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
