abstract class StorageServiceInterface {
  List getAll<T>();
  bool hasValue(String key);
  Future<void> clearAll();
  Future<void> writeValue<T>({required String key, required T data});
  T readValue<T>(String key);
  Future<void> deleteValue(String key);
}
