// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_test/src/data/local/app_database.dart';
import 'package:ecommerce_test/src/data/repositories/interfaces/i_local_repository.dart';

// Project imports:
import '../../../../core/config/injector.dart';
import '../../../../core/error/error.dart';
import '../../../../core/utils/data_state.dart';
import '../../../../data/models/product_model.dart';
import '../../../../data/repositories/local_repository_impl.dart';
import 'local_data_state.dart';

class LocalDataBloc extends Cubit<LocalDataState> {
  late final LocalAppRepository localDb;

  LocalDataBloc() : super(const LocalDataIdle()) {
    localDb = LocalRepositoryImpl(appDatabase: injector<AppDatabase>());
  }

  Future<void> getLocalData() async {
    emit(const LocalDataLoading());
    final DataState<List<ProductModel>> dataState = await localDb.get();
    dataState.when(
      success: (successState) {
        emit(LocalDataSuccess(data: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  Future<void> clearLocalData() async {
    emit(const LocalDataLoading());
    final DataState<bool> dataState = await localDb.clear();
    dataState.when(
      success: (successState) {
        emit(const LocalDataSuccess(data: []));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  Future<void> removeLocalData(int id) async {
    emit(const LocalDataLoading());
    final DataState<bool> dataState = await localDb.remove(id);
    dataState.when(
      success: (successState) {
        emit(LocalDataRemoveProductSuccess(result: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  Future<void> storeLocalData(ProductModel product) async {
    emit(const LocalDataLoading());
    final DataState<bool> dataState = await localDb.store(product);
    dataState.when(
      success: (successState) {
        emit(LocalDataStoreProductSuccess(result: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  DataState<bool> dataIsExist(int id) {
    return localDb.isExist(id);
  }

  void _emitError(
    AppError errorState,
  ) {
    emit(LocalDataError(error: errorState));
  }
}
