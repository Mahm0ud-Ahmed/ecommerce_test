import 'model_type.dart';

List<T> parseApiPagination<T>(List data) {
  final result = data.map<T>((json) => parseModel<T>(json)).toList();
  return result;
}

T parseModel<T>(dynamic json) => ModelType.getParseData<T>(json);
