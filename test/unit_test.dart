import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

//
import 'package:todo_list/app/data/models/task.dart';
import 'package:todo_list/app/helper/datetime_helper.dart';
import 'package:todo_list/app/helper/string_helper.dart';
import 'package:todo_list/app/routes/app_routes.dart';
import 'package:todo_list/main.dart';

import 'setup/test_helpers.dart';

void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

void main() async {
  sqfliteTestInit();
  WidgetsFlutterBinding.ensureInitialized();
  const String initialRoute = Routes.splash;
  runApp(const App(initialRoute: initialRoute));
  group('initialApp', () {
    setUp(() => registerServices());
    group('Check database', () {
      //All test cases are based on the default value. Which is initialized when running the app first
      //Checking default value in HomeController.

      test('When run app the first', () async {
        await Future.delayed(const Duration(milliseconds: 2000));
        expect(await isExitsDataTable(), true);
      });

      test('When run app after initialized', () async {
        expect(await isAddedDefaultData(), true);
      });

      test('When add a new task into table', () async {
        expect(await addNewTask(), true);
      });

      test('When update a task with default value', () async {
        expect(await updateTask(), true);
      });

      test('When running the app for the first time', () async {
        expect(await defaultFilter(), true);
      });

      test('When select any date to filter', () async {
        expect(await filterNoResult(), true);
      });
    });
  });

  group('Validate TaskModel when add a new task', () {
    test('When creating new Task having invalid date', () {
      var task = Task(finishDay: 31, finishMonth: 13, finishYear: 2012);

      expect(DateTimeHelper.validateDateTime(task.finishYear ?? 0, task.finishMonth ?? 0, task.finishDay ?? 0), false);
    });

    test('When creating new Task having valid date', () {
      var task = Task(finishDay: 12, finishMonth: 06, finishYear: 2022);

      expect(DateTimeHelper.validateDateTime(task.finishYear ?? 0, task.finishMonth ?? 0, task.finishDay ?? 0), true);
    });

    test('When creating new Task having invalid title and invalid description', () {
      var task = Task(title: '!@#&New @!#!@#Task 1(/', description: '!,.,^This is new @!#!@#(/description');
      expect(StringHelper.replaceSpecialChars(task.title), 'New Task 1');
      expect(StringHelper.replaceSpecialChars(task.description), 'This is new description');
    });

    test('When creating new Task having invalid title and invalid description', () {
      var task = Task(title: 'New Task 2', description: 'This is new description');
      expect(StringHelper.replaceSpecialChars(task.title), 'New Task 2');
      expect(StringHelper.replaceSpecialChars(task.description), 'This is new description');
    });
  });
}
