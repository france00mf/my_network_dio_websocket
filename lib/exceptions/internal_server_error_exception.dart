import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/errors.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';

class InternalServerErrorException extends DioException implements Failure{
  @override
  // TODO: implement title
  String get title => throw UnimplementedError();

  @override
  String toString(){
    return "Erro em :\n Titulo $title \n Mensagem $message";
  }

  @override
  String get title => "Erro de servidro";

  @override
  String get message {
    _logger.e(serverResponse?.data);
    return "Erro desconhecido, tente novamente";
  }

  String getErrorInfo(error, [String key='']){
      return getErrorInfoFromResponse(error);
  }
}