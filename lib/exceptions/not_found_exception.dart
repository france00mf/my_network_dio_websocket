import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/failure.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';

const unknowErrorString = "Ocorreu um erro, tente novamente";

class NotFoundException extends DioException implements Failure{
  final RequestOptions rOptions;
  final Response? serverResponse;
  final String errorServerKey;
  NotFoundException(this.rOptions, [this.serverResponse, this.errorServerKey='']) : super(requestOptions: rOptions,response: serverResponse);

  @override
  String toString()=> "Titulo: $title \n Mensagem: $message";

  @override
  String get message {
    if(serverResponse == null){
      return unknowErrorString;
    }else{
      return getErrorInfo(serverResponse!.data, errorServerKey);
    }
  }

  @override
  String get title{
    return "Não encontrado";
  }

  String getErrorInfo(error, [String key='']){
    return getErrorInfoFromResponse(error);
  }
}