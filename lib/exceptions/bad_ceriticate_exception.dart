import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/errors.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';

class BadCertificateException extends DioException implements Failure{
    final RequestOptions request;
  final Response? serverResponse;
  final String errorKey;

  BadCertificateException(this.request, [this.serverResponse, this.errorKey='mensagem']): super(requestOptions: request, response: serverResponse);

  @override
  String get title => 'Bad Certificate';

    @override
  String get message {
    if (serverResponse == null) {
      return 'Um erro inisperado aconteceu';
    } else {
      return getErrorInfo(serverResponse?.data, errorKey);
    }
  }
  
  
  String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
}