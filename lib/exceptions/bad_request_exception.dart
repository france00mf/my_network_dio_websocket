import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/failure.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';
import 'package:my_network_dio_websocket/utils/app_logger.dart';

const _unkownErrorString = "Ocorreu um erro, tente novamente";

class BadRequestException extends DioException implements Failure{

    final _logger = appLogger(BadRequestException);
  final RequestOptions request;
  final Response? serverResponse;
  final String errorKey;

  BadRequestException(
    this.request, [this.serverResponse, this.errorKey= "" ]
  ):super(requestOptions: request, response: serverResponse);


  @override
  // TODO: implement title
  String get title {
    if(serverResponse==null){
      return "Falha na Requisição";
    }
    return serverResponse?.data["message"]??"";
  }

    @override
  String get message {
    _logger.d(serverResponse?.data);
    if (serverResponse == null) {
      return _unkownErrorString;
    } else {
      return getErrorInfo(serverResponse?.data, errorKey);
    }
  }

   String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }
  
}