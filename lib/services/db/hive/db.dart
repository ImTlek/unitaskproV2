import 'package:hive_flutter/hive_flutter.dart';
import 'package:unitaskpro/services/db/hive/hive.dart';
 

class HiveStorageService implements StorageServiceInterface {
  late Box hiveBox;

  Future<void> initHive(String boxName) async {
    await Hive.initFlutter();
    hiveBox = await Hive.openBox(boxName);

  }

  Future<void> closeBox() => hiveBox.close();

  @override
  Future<void> clearAll() => hiveBox.clear();

  @override
  Future<void> deleteValue(String key) => hiveBox.delete(key);

  @override
  List getAll<T>() => hiveBox.values.toList();

  @override
  bool hasValue(String key) => hiveBox.containsKey(key);

  @override
  T readValue<T>(String key) => hiveBox.get(key);

  @override
  Future<void> writeValue<T>({required String key, required T data}) =>
      hiveBox.put(key, data);
}
