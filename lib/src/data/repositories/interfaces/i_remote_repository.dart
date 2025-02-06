import 'package:ecommerce_test/src/core/utils/api_info.dart';
import 'package:ecommerce_test/src/core/utils/data_state.dart';

abstract class IRemoteRepository<T> {
  Future<DataState<List<T>>> getDataList(ApiInfo apiInfo);
}
