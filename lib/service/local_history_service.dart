// import 'package:example/core.dart';
import 'local_storage_service.dart';

// Box mainStorage = Hive.box("mainStorage");

class LocalHistoryService {
  static List point = [];

  static save() async {
    await mainStorage.put("history", point);
  }

  static load() async {
    point = await mainStorage.get("history") ?? [];
  }

  static add(Map newProduct) async {
    point.add(newProduct);
    await save();
  }

  static delete(Map product) async {
    point.remove(product);
    await save();
  }

  static update(int index, Map newProduct) async {
    point[index] = newProduct;
    await save();
  }

  static reset() async {
    await mainStorage.delete("history");
  }
}
