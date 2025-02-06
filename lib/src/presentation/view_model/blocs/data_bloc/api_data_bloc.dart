// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import '../../../../core/error/error.dart';
import '../../../../core/utils/api_info.dart';
import '../../../../core/utils/data_state.dart';
import '../assistance/base_bloc_helper.dart';
import 'api_data_state.dart';

class ApiDataBloc<MODEL> extends Cubit<ApiDataState<MODEL>> {
  BaseBlocHelper<MODEL>? _helper;

  ApiDataBloc() : super(const ApiDataIdle()) {
    _helper = BaseBlocHelper<MODEL>(cubit: this);
  }

  Future<void> getGeneralData({required ApiInfo info}) async {
    /* emit(ApiDataLoading<MODEL>());
    final DataState<MODEL> dataState = await _helper!.repository!.getSingleData(info);
    dataState.when(
      success: (successState) {
        emit(ApiDataSuccessModel<MODEL>(data: successState, response: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    ); */
  }

  Future<void> getIndexData({required ApiInfo info}) async {
    emit(ApiDataLoading<MODEL>());
    final DataState<List<MODEL>> dataState = await _helper!.repository!.getDataList(info);
    dataState.when(
      success: (successState) {
        emit(ApiDataSuccessModel(response: successState));
      },
      failure: (errorState) {
        _emitError(errorState);
      },
    );
  }

  void _emitError(
    AppError errorState,
  ) {
    emit(ApiDataError<MODEL>(error: errorState));
  }

  @override
  Future<void> close() {
    _helper!.repository = null;
    _helper = null;
    return super.close();
  }
}
