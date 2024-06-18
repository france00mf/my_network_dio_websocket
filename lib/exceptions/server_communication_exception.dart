import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/errors.dart';
import 'package:my_network_dio_websocket/exceptions/get_error.dart';

class ServerCommunicationException extends DioException implements Failure{

  ServerCommunicationException(this.r): super(requestOptions: r!.requestOptions);

  final Response? r;

  @override
  // TODO: implement title
  String get title => throw UnimplementedError();
  
  @override
  String toString(){
    return 'titulo: $title mensagem: $message';
  }

  @override
  String get message{
    return "Sem comunicação com o servidor, tente noutro momento";
  }

  String getErrorInfo(error, [String key='']){
    return getErrorInfoFromResponse(error);
  }
}