import 'package:hive/hive.dart';
import 'package:ecommerce_test/src/core/config/injector.dart';
import 'package:ecommerce_test/src/core/services/hive_service.dart';

import '../../core/error/app_exception.dart';
import '../models/product_model.dart';

class AppDatabase {
  late final Box<Map<dynamic, dynamic>> _box;

  Future<bool> save(ProductModel product) async {
    try {
      await _box.put(product.id, product.toJson());
      return true;
    } on HiveError catch (e) {
      throw AppException(e);
    } catch (e) {
      throw AppException(e);
    }
  }

  Future<bool> delete(int id) async {
    try {
      await _box.delete(id);
      return true;
    } on HiveError catch (e) {
      throw AppException(e);
    } catch (e) {
      throw AppException(e);
    }
  }

  List<Map<String, dynamic>> get() {
    try {
      return _box.values.map<Map<String, dynamic>>((e) => Map.from(e)).toList();
    } on HiveError catch (e) {
      throw AppException(e);
    } catch (e) {
      throw AppException(e);
    }
  }

  Future<bool> clear() async {
    try {
      await _box.clear();
      return true;
    } on HiveError catch (e) {
      throw AppException(e);
    } catch (e) {
      throw AppException(e);
    }
  }

  bool isExist(int id) {
    try {
      return _box.containsKey(id);
    } on HiveError catch (e) {
      throw AppException(e);
    } catch (e) {
      throw AppException(e);
    }
  }

  // singleton
  AppDatabase.init() {
    _box = injector<HiveService>().box;
  }
  static AppDatabase? _instance;
  factory AppDatabase() => _instance ??= AppDatabase.init();
}
