import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/errors.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';
import 'package:my_network_dio_websocket/utils/app_logger.dart';

class InternalServerErrorException extends DioException implements Failure{

  final _logger = appLogger(InternalServerErrorException);
  final RequestOptions oRequest;
  final Response? iResponse;

  InternalServerErrorException(
    this.oRequest, [this.iResponse]
  ): super(requestOptions: oRequest, response: iResponse);

  @override
  // TODO: implement title
  String get title => "Erro de servidor";

  @override
  String toString(){
    return "Erro em :\n Titulo $title \n Mensagem $message";
  }



  @override
  String get message {
    _logger.e(iResponse?.data);
    return "Erro desconhecido, tente novamente";
  }

  String getErrorInfo(error, [String key='']){
      return getErrorInfoFromResponse(error);
  }
}