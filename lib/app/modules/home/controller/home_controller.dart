import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

//
import 'package:todo_list/app/data/models/task.dart';
import 'package:todo_list/app/data/repository/task.repository.dart';
import 'package:todo_list/app/enums/enums.dart';
import 'package:todo_list/app/constants/database_constants.dart' as db;

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();
  final ITaskRepository repository = Get.find();
  var filterDate = DateTime.now().obs;
  RxInt filterStatus = RxInt(TaskStatus.all);
  RxInt countCompletedTasks = RxInt(0);
  RxDouble percentCompleted = RxDouble(0);
  Task task = Task(status: TaskStatus.inCompleted, categoryType: CategoryTask.home);
  bool hasInitValue = false;
  var tasks = RxList<Task>();
  Database? taskTable;

  @override
  void onInit() {
    super.onInit();
    _initTable();
  }

  Future _initTable() async {
    var taskTable = await repository.initTaskTable();
    this.taskTable = taskTable;
    repository.isInitDefaultValue(taskTable: taskTable, filterDate: filterDate.value).then((isInitDefaultValue) {
      if (!isInitDefaultValue) {
        initValue();
      }
    });
    fetchData();
  }

  onAddTask() {
    task.setFinishDate();
    addTaskToDB(task);
    tasks.insert(0, task);
  }

  Future fetchData() async {
    await filter();
  }

  filter({status}) async {
    List<Map<String, Object?>> results = <Map<String, Object?>>[];
    if (taskTable != null) {
      if (status != null) {
        filterStatus.value = status;
      }
      if (filterStatus.value != TaskStatus.all) {
        results = await repository.filterByStatus(taskTable: taskTable!, filterDate: filterDate.value, filterStatus: filterStatus.value);
      } else {
        results = await repository.filter(taskTable: taskTable!, filterDate: filterDate.value);
      }
      List<Task> tasks = results.map<Task>((item) => Task.fromJson(item)).toList();
      this.tasks.value = tasks;
      calculatePercentCompleted();
    }
  }

  Future<void> initValue() async {
    addTaskToDB(Task(
      categoryType: 1,
      title: "Learning",
      description: "Mobile design with Sketch",
      finishDate: DateTime.now().toString(),
      finishMonth: DateTime.now().month,
      finishYear: DateTime.now().year,
      finishDay: DateTime.now().day,
      status: TaskStatus.completed,
    ));
    addTaskToDB(Task(
      categoryType: 3,
      title: "Relaxing",
      description: "Son Tung Vol 2",
      finishDate: DateTime.now().toString(),
      finishMonth: DateTime.now().month,
      finishYear: DateTime.now().year,
      finishDay: DateTime.now().day,
      status: TaskStatus.completed,
    ));
    addTaskToDB(Task(
      categoryType: 2,
      title: "Learning",
      description: "Flutter BloC chapter 2",
      finishDate: DateTime.now().toString(),
      finishMonth: DateTime.now().month,
      finishYear: DateTime.now().year,
      finishDay: DateTime.now().day,
      status: TaskStatus.completed,
    ));
    addTaskToDB(Task(
      categoryType: 1,
      title: "Cleaning",
      description: "Clean the house",
      finishDate: DateTime.now().toString(),
      finishMonth: DateTime.now().month,
      finishYear: DateTime.now().year,
      finishDay: DateTime.now().day,
      status: TaskStatus.inCompleted,
    ));

    hasInitValue = true;
  }

  addTaskToDB(Task taskModel) async {
    try {
      await taskTable?.insert(
        db.task,
        taskModel.toJson(),
      );
      await fetchData();
    } catch (e) {
      print(e);
    }
  }

  Future updateTask(Task model) async {
    print(model.toJson());
    await taskTable!.update(
      db.task,
      model.toJson(),
      where: "id = ?",
      whereArgs: [model.id],
    );
    tasks.firstWhere((t) => t.id == model.id).status = model.status;
    fetchData();
  }

  calculatePercentCompleted() {
    countCompletedTasks.value = tasks.where((element) => element.completed).length;
    percentCompleted.value = countCompletedTasks.value / tasks.length;
  }
}
