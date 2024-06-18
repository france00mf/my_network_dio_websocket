import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/errors.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';

class DeadLineExceededException extends DioException implements Failure{
  DeadLineExceededException(RequestOptions e) : super(requestOptions: e);

  @override
  String toString(){
    return 'titulo: $title mensagem: $message';
  }

    @override
  String get message => "o tempo da ligação terminou , repita";

  
  @override
  String get title => "Erro de rede";

    String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }

}