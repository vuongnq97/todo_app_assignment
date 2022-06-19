// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    finishDate: json['finishDate'] as String?,
    finishDay: json['finishDay'] as int?,
    finishMonth: json['finishMonth'] as int?,
    finishYear: json['finishYear'] as int?,
    categoryType: json['categoryType'] as int?,
    status: json['status'] as int?,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'finishDate': instance.finishDate,
      'finishDay': instance.finishDay,
      'finishMonth': instance.finishMonth,
      'finishYear': instance.finishYear,
      'categoryType': instance.categoryType,
      'status': instance.status,
    };
