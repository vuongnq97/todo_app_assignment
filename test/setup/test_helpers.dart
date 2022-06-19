import 'package:get/get.dart';
import 'package:todo_list/app/data/models/task.dart';
import 'package:todo_list/app/data/providers/task.provider.dart';
import 'package:todo_list/app/data/repository/task.repository.dart';
import 'package:todo_list/app/enums/enums.dart';
import 'package:todo_list/app/modules/home/controller/home_controller.dart';

Future<bool> isExitsDataTable() {
  var homeController = HomeController.to;
  return Future.value(homeController.taskTable?.isOpen);
}

Future<bool> isAddedDefaultData() {
  var homeController = HomeController.to;
  return Future.value(homeController.tasks.isNotEmpty);
}

Future<bool> addNewTask() async {
  var homeController = HomeController.to;
  var taskLengthBefore = homeController.tasks.length;
  print("taskLengthBefore");
  print(homeController.tasks.length);

  var task = Task(
    categoryType: 2,
    title: 'New tank 1',
    description: 'This is new description for task 1',
    finishDate: DateTime.now().toString(),
    finishMonth: DateTime.now().month,
    finishYear: DateTime.now().year,
    finishDay: DateTime.now().day,
    status: TaskStatus.completed,
  );
  await homeController.addTaskToDB(task);
  await homeController.fetchData();
  var taskLengthAfter = homeController.tasks.length;
  print("taskLengthAfter");
  print(homeController.tasks.length);

  return Future.value((taskLengthAfter - taskLengthBefore) == 1);
}

Future<bool> updateTask() async {
  var homeController = HomeController.to;
  //Default Task has id equal 1. That is completed status.
  var task = Task(
    id: 1,
    categoryType: 1,
    title: "Learning",
    description: "Mobile design with Sketch",
    finishDate: DateTime.now().toString(),
    finishMonth: DateTime.now().month,
    finishYear: DateTime.now().year,
    finishDay: DateTime.now().day,
    status: TaskStatus.inCompleted,
  );
  await homeController.updateTask(task);
  await homeController.fetchData();
  var updatedTask = homeController.tasks.where((e) => e.id == 1).first;

  //Expected: After updated. This task is inCompleted status
  return Future.value(updatedTask.status == TaskStatus.inCompleted);
}

Future<bool> defaultFilter() async {
  var homeController = HomeController.to;

  //Default params: FinishDate is today. Status are inCompleted and completed
  await homeController.filter();

  //Expected: Having tasks in the database.
  return Future.value(homeController.tasks.isNotEmpty);
}

Future<bool> filterNoResult() async {
  var homeController = HomeController.to;
  //Default params: FinishDate is tomorrow. Status are inCompleted and completed
  var finishDate = DateTime.now().add(const Duration(days: 1));
  homeController.filterDate.value = finishDate;
  await homeController.filter();

  //Expected: No tasks in the database on the date.
  return Future.value(homeController.tasks.isEmpty);
}

void registerServices() async {
  Get.put<ITaskRepository>(TaskRepository(apiClient: TaskProvider()));
  Get.lazyPut(() => HomeController());
}
