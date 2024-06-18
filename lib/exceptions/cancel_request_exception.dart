import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/failure.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';

class CancelRequestException extends DioException implements Failure {
  @override
  final RequestOptions requestOptions;
  CancelRequestException(this.requestOptions)
      : super(requestOptions: requestOptions);
  @override
  String get message => "Requisição foi cancelada, tente novamente";

  @override
  String get title => "Requesição cancelada";

  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}
