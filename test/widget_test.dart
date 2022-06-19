import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:todo_list/app/routes/app_routes.dart';
import 'package:todo_list/main.dart';

@TestOn('ios')
void main() {
  testWidgets('Form Data Validation', (WidgetTester tester) async {
    final addTask = find.byKey(const Key("add_btn"));
    final formAddButton = find.byKey(const Key("form_add_btn"));
    WidgetsFlutterBinding.ensureInitialized();
    await tester.pumpWidget(const App(initialRoute: Routes.main));
    await tester.pumpAndSettle();
    await tester.tap(addTask);
    await tester.pump();

    // Expected: Open Form Task after click add button
    expect(find.byType(Form), findsOneWidget);

    await tester.ensureVisible(formAddButton);
    await tester.tap(formAddButton);
    await tester.pump();

    //Expected: Required texts are appeared when don't enter text into the form
    expect(find.text('Required'), findsWidgets);

    await tester.enterText(find.byKey(const Key("task_title")), 'New Task 2');
    await tester.enterText(find.byKey(const Key("task_description")), 'This is a new description');

    await tester.drag(find.byKey(const Key('scroll_form')), const Offset(0.0, -200));
    await tester.pump();

    //Enter finish date is invalid
    await tester.enterText(find.byKey(const Key("task_day")), '33');
    await tester.enterText(find.byKey(const Key("task_month")), '13');
    await tester.enterText(find.byKey(const Key("task_year")), '2022');

    await tester.ensureVisible(formAddButton);
    await tester.tap(formAddButton);
    await tester.pumpAndSettle();

    //Expected: Will appear finish date error message
    expect(find.byKey(const Key('finish_date_error')), findsOneWidget);
  });

  testWidgets('Home Screen', (WidgetTester tester) async {
    final completedTasksAppBarItem = find.byIcon(Icons.check_circle_outline);
    final allTasksAppBarItem = find.byIcon(Icons.pending);
    final inCompletedTasksAppBarItem = find.byIcon(Icons.access_time_rounded);
    final addTask = find.byKey(const Key("add_btn"));

    WidgetsFlutterBinding.ensureInitialized();
    Get.testMode = true;
    await tester.pumpWidget(const App(initialRoute: Routes.main));

    expect(addTask, findsOneWidget);

    await tester.tap(completedTasksAppBarItem);
    await tester.pump();
    // Expected: Change App Title to  Completed Tasks
    expect(find.text('completeTasks'.tr), findsOneWidget);

    await tester.tap(allTasksAppBarItem);
    await tester.pump();
    // Expected: Change App Title to  Completed Tasks
    expect(find.text('allTasks'.tr), findsOneWidget);

    await tester.tap(inCompletedTasksAppBarItem);
    await tester.pump();
    // Expected: Change App Title to  InComplete Tasks
    expect(find.text('inCompleteTasks'.tr), findsOneWidget);

    //Default Filter on the today
    expect(find.text('today'.tr), findsOneWidget);

    //Filter on the monday
    await tester.tap(find.text('Mon'));
    await tester.pump();

    // Expected: No result by default data in the database
    expect(find.text('noResult'.tr), findsOneWidget);
  });
}
