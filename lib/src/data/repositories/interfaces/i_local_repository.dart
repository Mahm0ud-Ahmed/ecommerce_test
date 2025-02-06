import 'package:ecommerce_test/src/core/utils/data_state.dart';

import '../../models/product_model.dart';

abstract class LocalAppRepository {
  Future<DataState<bool>> store(ProductModel product);
  Future<DataState<List<ProductModel>>> get();
  Future<DataState<bool>> remove(int id);
  Future<DataState<bool>> clear();
  DataState<bool> isExist(int id);
}
