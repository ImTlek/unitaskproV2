import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:unitaskpro/model/list.dart';
import 'package:unitaskpro/model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unitaskpro/services/db/list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SectionProvider extends AsyncNotifier<Map<dynamic, ListModel>>
    with Disposable {
  Map<dynamic, ListModel> get data => ListHive.box.toMap();
  @override
  FutureOr<Map<dynamic, ListModel>> build() async {
    addListen();
    return data;
  }

  void addListen() {
    ListHive.box.listenable().addListener(refreshListenr);
  }

  Future<void> remove(dynamic id) => ListHive.deleteValue(id);

  Future<void> removeTask(dynamic key, TaskModel taskModel) =>
      ListHive.deleteTask(key, taskModel);

  Future<void> removeTaskById(TaskModel taskModel) async {
    data.forEach((key, listModel) {
      int index = listModel.tasks.indexWhere((task) => task.id == taskModel.id);
      if (index != -1) {
        listModel.tasks.removeAt(index);
      }
    });

    ListHive.pustAll(data);
  }

  void addSection(String title, BuildContext context) async {
    var now = DateTime.now();
    ListModel listModel = ListModel(
      title: title,
      createdAt: now,
      description: 'description',
      icon: 'icon',
      tasks: [],
      updatedAt: now,
    );

    ListHive.add(listModel).then((value) {
      Navigator.pop(context);
    });
  }

  void clear() {
    ListHive.clearAll();
  }

  @override
  FutureOr onDispose() {
    ListHive.box.listenable().removeListener(refreshListenr);
  }

  void refreshListenr() {
    update((_) => data);
  }

  Future<void> addTask(
      MapEntry<dynamic, ListModel> data, TaskModel taskModel) async {
    data.value.tasks.add(taskModel);

    await ListHive.update(data.key, data.value);

    refreshListenr();
  }

  Future<void> updateTask(dynamic key, TaskModel taskModel) async {
    var listModel = data[key];
    var tasks = listModel?.tasks;
    var indexWhere = tasks?.indexWhere((e) => e.id == taskModel.id);

    if (listModel != null && tasks != null) {
      if (indexWhere != null) {
        tasks.removeAt(indexWhere);
        tasks.insert(indexWhere, taskModel);
        await ListHive.update(key, listModel);
      }
    }
  }

  Future<void> updateTaskById(TaskModel taskModel) async {
    // Iterate over each entry in the datas map
    data.forEach((key, listModel) {
      // Find the index of the task with the given taskId
      int index = listModel.tasks.indexWhere((task) => task.id == taskModel.id);
      // If task with taskId is found
      if (index != -1) {
        // Update the isMyDay property of the task
        listModel.tasks[index] = listModel.tasks[index].copyWith(
            isMyDay: taskModel.isMyDay,
            createdAt: taskModel.createdAt,
            description: taskModel.description,
            finishedAt: taskModel.finishedAt,
            id: taskModel.id,
            img: taskModel.img,
            isDone: taskModel.isDone,
            isStar: taskModel.isStar,
            startedAt: taskModel.startedAt,
            title: taskModel.title,
            updatedAt: taskModel.updatedAt);
      }
    });

    ListHive.pustAll(data);
  }

//

  TaskModel? getcurrentTask(dynamic key, TaskModel taskModel) {
    var listModel = data[key];
    var tasks = listModel?.tasks;
    var indexWhere = tasks?.indexWhere((e) => e.id == taskModel.id);

    if (tasks != null && indexWhere != null && indexWhere != -1) {
      var task = tasks[indexWhere];
      return task;
    }
    return null;
  }

  TaskModel? getcurrentTaskById(String id) {
    TaskModel? task;
    data.forEach((key, listModel) {
      int index = listModel.tasks.indexWhere((task) => task.id == id);

      if (index != -1) {
        task = listModel.tasks[index];
      }
    });
    return task;
  }
}

var sectionProvider =
    AsyncNotifierProvider<SectionProvider, Map<dynamic, ListModel>>(
        SectionProvider.new);
