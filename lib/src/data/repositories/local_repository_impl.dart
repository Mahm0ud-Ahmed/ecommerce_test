import 'dart:convert';

import 'package:ecommerce_test/src/core/utils/data_state.dart';
import 'package:ecommerce_test/src/data/local/app_database.dart';
import 'package:ecommerce_test/src/data/repositories/interfaces/i_local_repository.dart';

import '../../core/error/app_exception.dart';
import '../models/product_model.dart';

class LocalRepositoryImpl implements LocalAppRepository {
  final AppDatabase appDatabase;

  LocalRepositoryImpl({required this.appDatabase});

  @override
  Future<DataState<bool>> clear() async {
    try {
      final result = await appDatabase.clear();
      return DataState<bool>.success(result);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  Future<DataState<List<ProductModel>>> get() async {
    try {
      final result = appDatabase.get();
      return DataState<List<ProductModel>>.success(
        result.map((e) {
          final Map<String, dynamic> data = jsonDecode(jsonEncode(e));
          return ProductModel.fromJson(data);
        }).toList(),
      );
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  DataState<bool> isExist(int id) {
    try {
      final result = appDatabase.isExist(id);
      return DataState<bool>.success(result);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  Future<DataState<bool>> remove(int id) async {
    try {
      final result = await appDatabase.delete(id);
      return DataState<bool>.success(result);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }

  @override
  Future<DataState<bool>> store(ProductModel product) async {
    try {
      final result = await appDatabase.save(product);
      return DataState<bool>.success(result);
    } on AppException catch (error) {
      return DataState.failure(AppException(error).handleError);
    } catch (error) {
      return DataState.failure(AppException(error).handleError);
    }
  }
}
