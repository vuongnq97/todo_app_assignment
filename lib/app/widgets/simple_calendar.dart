import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//
import 'package:todo_list/app/data/models/simple_calendar.dart';
import 'package:todo_list/app/helper/datetime_helper.dart';
import 'package:todo_list/app/widgets/shadow_box.dart';

class SimpleCalender extends StatefulWidget {
  final Function(DateTime)? onSelectedDate;

  const SimpleCalender({Key? key, this.onSelectedDate}) : super(key: key);

  @override
  _SimpleCalenderState createState() => _SimpleCalenderState();
}

class _SimpleCalenderState extends State<SimpleCalender> {
  List<SimpleCalenderItem> items = [];

  @override
  void initState() {
    super.initState();
    initValue();
  }

  void updateSelected(int dayOfWeek) {
    items.forEach((element) {
      element.isSelected = element.dayOfWeekValue == dayOfWeek;
    });
    setState(() {});
  }

  void initValue() {
    var currentDate = DateTime.now();

    //Generate form monday to sunday
    for (int i = 2; i <= 8; i++) {
      var dayOfWeek = DateTimeHelper.getDayOfWeek(i);

      items.add(SimpleCalenderItem(
          dayOfWeek: dayOfWeek,
          isSelected: currentDate.weekday + 1 == i,
          dayOfWeekName: DateFormat("EEE").format(dayOfWeek),
          dayOfWeekValue: dayOfWeek.day));
    }
  }

  Widget simpleCalenderItem(SimpleCalenderItem item) {
    return InkWell(
      onTap: () {
        updateSelected(item.dayOfWeekValue!);
        widget.onSelectedDate!(item.dayOfWeek!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.dayOfWeekName!,
              style: TextStyle(fontSize: 14.sp),
            ),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: item.isSelected! ? Colors.green : Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                item.dayOfWeekValue.toString(),
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShadowBox(
      height: context.isTablet ? 82 : 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                SimpleCalenderItem item = items[index];
                return simpleCalenderItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
