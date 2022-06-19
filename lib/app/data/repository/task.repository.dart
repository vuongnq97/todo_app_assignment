import 'package:sqflite/sqflite.dart';

//
import 'package:todo_list/app/data/providers/task.provider.dart';
//

abstract class ITaskRepository {
  Future<Database> initTaskTable();

  Future<List<Map<String, Object?>>> filter({required Database taskTable, required DateTime filterDate});

  Future<bool> isInitDefaultValue({required Database taskTable, required DateTime filterDate});

  Future<List<Map<String, Object?>>> filterByStatus({required Database taskTable, required DateTime filterDate, required int filterStatus});
}

class TaskRepository implements ITaskRepository {
  final TaskProvider apiClient;

  TaskRepository({required this.apiClient});

  @override
  Future<Database> initTaskTable() {
    return apiClient.initTaskTable();
  }

  @override
  Future<List<Map<String, Object?>>> filter({required Database taskTable, required DateTime filterDate}) {
    return apiClient.filter(taskTable: taskTable, filterDate: filterDate);
  }

  @override
  Future<List<Map<String, Object?>>> filterByStatus({required Database taskTable, required DateTime filterDate, required int filterStatus}) {
    return apiClient.filterByStatus(taskTable: taskTable, filterDate: filterDate, filterStatus: filterStatus);
  }

  @override
  Future<bool> isInitDefaultValue({required Database taskTable, required DateTime filterDate}) {
    return apiClient.isInitDefaultValue(taskTable: taskTable, filterDate: filterDate);
  }
}
