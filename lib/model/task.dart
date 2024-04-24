import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
@immutable
class TaskModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime startedAt;
  @HiveField(3)
  final DateTime finishedAt;
  @HiveField(4)
  final DateTime createdAt;
  @HiveField(5)
  final DateTime updatedAt;
  @HiveField(6)
  final bool isStar;
  @HiveField(7)
  final bool isDone;
  @HiveField(8)
  final String id;
  @HiveField(9)
  final String img;
  @HiveField(10)
  final bool isMyDay;

  const TaskModel(
      {required this.title,
      required this.description,
      required this.startedAt,
      required this.finishedAt,
      required this.createdAt,
      required this.updatedAt,
      required this.isStar,
      required this.isDone,
      required this.id,
      required this.img,
      required this.isMyDay});

  TaskModel copyWith(
      {String? title,
      String? description,
      DateTime? startedAt,
      DateTime? finishedAt,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool? isStar,
      bool? isDone,
      String? id,
      String? img,
      bool? isMyDay}) {
    return TaskModel(
        title: title ?? this.title,
        description: description ?? this.description,
        startedAt: startedAt ?? this.startedAt,
        finishedAt: finishedAt ?? this.finishedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isStar: isStar ?? this.isStar,
        isDone: isDone ?? this.isDone,
        id: id ?? this.id,
        img: img ?? this.img,
        isMyDay: isMyDay ?? this.isMyDay);
  }

  @override
  String toString() {
    return 'TaskModel{title=$title, description=$description, startedAt=$startedAt, finishedAt=$finishedAt, createdAt=$createdAt, updatedAt=$updatedAt, isStar=$isStar, isDone=$isDone, id=$id, img=$img, isMyDay=$isMyDay}';
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      description: json['description'],
      startedAt: DateTime.parse(json['startedAt']),
      finishedAt: DateTime.parse(json['finishedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isStar: json['isStar'],
      isDone: json['isDone'],
      id: json['id'],
      img: json['img'],
      isMyDay: json['isMyDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startedAt': startedAt.toIso8601String(),
      'finishedAt': finishedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isStar': isStar,
      'isDone': isDone,
      'id': id,
      'img': img,
      'isMyDay': isMyDay,
    };
  }
}
