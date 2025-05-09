// part of 'api_data_bloc.dart';

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import '../../../../core/error/error.dart';
import '../../../../data/models/product_model.dart';

part 'local_data_state.freezed.dart';

@freezed
class LocalDataState with _$LocalDataState {
  const factory LocalDataState.idle() = LocalDataIdle;

  const factory LocalDataState.loading() = LocalDataLoading;

  const factory LocalDataState.success({
    required List<ProductModel> data,
  }) = LocalDataSuccess;

  const factory LocalDataState.removeProduct({
    required bool result,
  }) = LocalDataRemoveProductSuccess;

  const factory LocalDataState.isExist({
    required bool result,
  }) = LocalDataExistProductSuccess;

  const factory LocalDataState.successStoreProduct({
    required bool result,
  }) = LocalDataStoreProductSuccess;

  const factory LocalDataState.error({required AppError? error}) = LocalDataError;
}
