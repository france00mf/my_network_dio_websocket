

import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/errors.dart';
import 'package:my_network_dio_websocket/utils/app_logger.dart';

const _unkownErrorString = "Ocorreu um erro, tente novamente";
class ConflictException extends DioException implements Failure{
    final _logger = appLogger(ConflictException);
    final RequestOptions request;
    final Response? serverResponse;
    final String errorKey;

    ConflictException(this.request, [this.serverResponse, this.errorKey='']):super(requestOptions: request, response: serverResponse);
    
      @override
      // TODO: implement title
      String get title => throw UnimplementedError();

    @override
    String toString(){
      return "erro em : \nTitulo $title\nMensagem: $message";
    }
    
}