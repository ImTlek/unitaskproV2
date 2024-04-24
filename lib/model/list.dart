import 'package:unitaskpro/model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'list.g.dart';

@HiveType(typeId: 2)
class ListModel {
  ListModel(
      {required this.title,
      required this.icon,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.tasks});

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String icon;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final DateTime updatedAt;
  @HiveField(5)
  final List<TaskModel> tasks;

  ListModel copyWith(
      {String? title,
      String? icon,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<TaskModel>? tasks}) {
    return ListModel(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tasks: tasks ?? this.tasks);
  }

  @override
  String toString() {
    return 'ListModel{title=$title, icon=$icon, description=$description, createdAt=$createdAt, updatedAt=$updatedAt, tasks=$tasks}';
  }



  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      title: json['title'],
      icon: json['icon'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      tasks: (json['tasks'] as List<dynamic>)
          .map((taskJson) => TaskModel.fromJson(taskJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

}
