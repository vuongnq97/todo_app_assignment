import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list/app/enums/enums.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  int? id;
  String? title;
  String? description;
  String? finishDate;
  int? finishDay;
  int? finishMonth;
  int? finishYear;
  int? categoryType;
  int? status;

  Task({this.id, this.title, this.description, this.finishDate, this.finishDay, this.finishMonth, this.finishYear, this.categoryType, this.status});

  get completed {
    return status == TaskStatus.completed;
  }

  set completed(value) {
    status = value;
  }

  setFinishDate() {
    finishDate = DateTime(finishYear!, finishMonth!, finishDay!).toString();
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
