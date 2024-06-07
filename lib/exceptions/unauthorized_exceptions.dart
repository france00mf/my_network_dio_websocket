

import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/failure.dart';


const _unkownErrorString = "An error occured, please try again. ";

class UnAuthorizedException extends DioException implements Failure{
  final RequestOptions request;
  final Response? serverResponse;
  final String errorKey;

  UnAuthorizedException( this.request, [  this.serverResponse,  this.errorKey='']) : super(requestOptions: request, response: serverResponse);
  
  
  @override
  String toString() {
    return "Error was:\nTitle: $title\nMessage: $message ";
  }
  
    @override
  String get message {
    if (serverResponse == null) {
      return _unkownErrorString;
    } else {
      return getErrorInfo(serverResponse?.data, errorKey);
    }
  }

  @override
  String get title => "Acess denies";


    String getErrorInfo(error, [String key = '']) {
    return getErrorInfoFromResponse(error);
  }


}