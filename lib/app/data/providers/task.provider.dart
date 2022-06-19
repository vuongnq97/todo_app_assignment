import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

//
import 'package:todo_list/app/constants/database_constants.dart';
import 'package:todo_list/app/constants/database_constants.dart' as db;
//

class TaskProvider {

  Future<Database> initTaskTable() async {
    return openDatabase(
      join(await getDatabasesPath(), 'task.db'),
      onCreate: (taskDB, version) {
        return taskDB.execute(
          'CREATE TABLE IF NOT EXISTS $task('
          'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, '
          'title TEXT, '
          'description TEXT, '
          'finishDate TEXT, '
          'finishDay INTEGER, '
          'finishMonth INTEGER, '
          'finishYear INTEGER, '
          'categoryType INTEGER, '
          'status INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<Map<String, Object?>>> filter({required Database taskTable,required DateTime filterDate}) async {
    return await taskTable.rawQuery("SELECT * FROM ${db.task} WHERE finishYear = ${filterDate.year}"
        " and finishMonth =${filterDate.month} and finishDay = ${filterDate.day}");
  }

  Future<List<Map<String, Object?>>> filterByStatus({required Database taskTable,required DateTime filterDate, required int filterStatus}) async {
    return await taskTable.rawQuery("SELECT * FROM ${db.task} WHERE finishYear = ${filterDate.year}"
        " and finishMonth =${filterDate.month} and finishDay = ${filterDate.day} and status = $filterStatus");
  }

  Future<bool> isInitDefaultValue({required Database taskTable,required DateTime filterDate}) async {
    print(filterDate);
    return (await taskTable.rawQuery("SELECT * FROM ${db.task} WHERE finishYear = ${filterDate.year}"
        " and finishMonth =${filterDate.month} and finishDay = ${filterDate.day} and id=1")).length == 1;
  }

}
