import 'package:unitaskpro/main.dart';
import 'package:flutter/material.dart';
import 'package:unitaskpro/model/list.dart';
import 'package:unitaskpro/model/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unitaskpro/services/firebase/sync/sync.dart';

const String _jpBox = 'listB';

@immutable
final class ListHive {
  const ListHive._();
  static late final Box<ListModel> _box;
  static Box<ListModel> get box => _box;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ListModelAdapter());
    Hive.registerAdapter(TaskModelAdapter());
    _box = await Hive.openBox(_jpBox);
  }

  static Future<int> add(ListModel model) async {
    var i = await _box.add(model);
    synFire();
    return i;
  }

  static Future<void> writeValue(String key, ListModel model) async {
    await _box.put(key, model);

    synFire();
  }

  static ListModel? readValue(String key) => _box.get(key);

  static List<ListModel> readAll() {
    return _box.values.toList();
  }

  static Future<void> deleteValue(dynamic key) async {
    try {
      await _box.delete(key);
      await Syncer.deleteListModel(key.toString());
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteTask(dynamic key, TaskModel taskModel) async {
    try {
      var listModel = _box.get(key);
      if (listModel != null) {
        listModel.tasks.removeWhere((e) => e.id == taskModel.id);
        await _box.put(key, listModel);
        await Syncer.deleteListModel(key);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> clearAll() async {
    await _box.clear();
  }

  static Future<void> close() async {
    await _box.close();
  }

  static Future<void> update(dynamic key, ListModel listModel) async {
    try {
      await _box.put(key, listModel);
      synFire();
    } catch (e) {
      logs(e);
    }
  }

  static void pustAll(Map<dynamic, ListModel> entries) async {
    await _box.putAll(entries);
    synFire();
  }

  static Future<void> synFire() async {
    var map = _box.toMap();
    await Syncer.syncList(map);
  }
}
