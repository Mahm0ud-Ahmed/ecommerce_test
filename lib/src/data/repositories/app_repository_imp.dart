// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_test/src/core/utils/data_state.dart';
import 'package:ecommerce_test/src/data/repositories/parsing_power.dart';

import '../../core/error/app_exception.dart';
import '../remote/dio_api_service.dart';
import 'interfaces/i_remote_repository.dart';

class AppRepositoryImp<T> extends IRemoteRepository<T> {
  final DioApiService dioApiService;
  AppRepositoryImp({
    required this.dioApiService,
  });

  @override
  Future<DataState<List<T>>> getDataList(apiInfo) async {
    try {
      final response = await dioApiService.action(query: apiInfo);

      final responseModel = parseApiPagination<T>(response.data);

      return DataState<List<T>>.success(responseModel);
    } on AppException catch (error) {

      return DataState.failure(AppException(error).handleError);
    } on TypeError catch (error) {

      return DataState.failure(AppException(error).handleError);
    } catch (error) {

      return DataState.failure(AppException(error).handleError);
    }
  }
}
