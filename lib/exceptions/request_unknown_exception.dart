import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/failure.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';

class RequestUnknownExcpetion extends DioException implements Failure {
    final Response? serverResponse;
  @override
  final RequestOptions requestOptions;

  RequestUnknownExcpetion( this.requestOptions, [this.serverResponse]): super(requestOptions: requestOptions,response: serverResponse );


  @override
  String get title => 'Resposta disconhecida';

  @override
  String get message => "Servidor enviou uma resposta disconhecida";

  String getErrorInfo(error, [String key ='']){
    return getErrorInfoFromResponse(error);
  }
  
}