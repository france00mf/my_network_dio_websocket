
import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/errors.dart';
import 'package:my_network_dio_websocket/exceptions/bad_ceriticate_exception.dart';
import 'package:my_network_dio_websocket/exceptions/bad_request_exception.dart';
import 'package:my_network_dio_websocket/exceptions/cancel_request_exception.dart';
import 'package:my_network_dio_websocket/exceptions/conflict_exception.dart';
import 'package:my_network_dio_websocket/exceptions/deadline_exceeded_exception.dart';
import 'package:my_network_dio_websocket/exceptions/internal_server_error_exception.dart';
import 'package:my_network_dio_websocket/exceptions/not_found_exception.dart';
import 'package:my_network_dio_websocket/exceptions/request_unknown_exception.dart';
import 'package:my_network_dio_websocket/exceptions/server_communication_exception.dart';
import 'package:my_network_dio_websocket/exceptions/unauthorized_exceptions.dart';
import 'package:my_network_dio_websocket/utils/app_logger.dart';

class NetworkServiceInterceptors extends Interceptor{
  final _logger = const AppLogger(NetworkServiceInterceptors);
  final Dio dio;
  String? token;
  final String errorKey;
  Function(DioException err, ErrorInterceptorHandler handler)? onErrorCustom;

  NetworkServiceInterceptors(
    this.dio,

    {
      this.errorKey='',
    this.onErrorCustom
    }
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler)async {
    // TODO: implement onError

      _logger.e("Error from Dio: ",
        functionName: "onError", error: err.toString());
        if(err.response?.statusCode!=null){
            switch(err.response?.statusCode){
                case 400:
          err = BadRequestException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;

              case 401:
          err = UnAuthorizedException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;
          
          case 403:
          err = UnAuthorizedException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;

           case 404:
          err = NotFoundException(
            err.requestOptions,
            err.response,
            errorKey,
          );
          break;
           case 500:
            err = InternalServerErrorException(
              err.requestOptions,
              err.response
            );
            break;
            case 503:
            err = ServerCommunicationException(
              err.response
            );
            break;
            default:
              err = RequestUnknownExcpetion(
                err.requestOptions, 
                err.response
              );
            }
        } else{
          switch (err.type) {
            case DioExceptionType.connectionError:
            case DioExceptionType.sendTimeout:
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.connectionTimeout:
              err = DeadLineExceededException(err.requestOptions);            
              break;
            case DioExceptionType.badCertificate:
              err = BadCertificateException(err.requestOptions);
            case DioExceptionType.badResponse:
              err = BadRequestException(err.requestOptions);
            case DioExceptionType.cancel:
              err = CancelRequestException(err.requestOptions);
              break;
            case DioExceptionType.unknown:
              err = RequestUnknownExcpetion(err.requestOptions);
              break ;

            
          }
        }

    return handler.next(err);
  }

  @override
  Future<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler
  ) async{
    return handler.next(options); 
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async{
    // TODO: implement onResponse
    checkStatusCode(response.requestOptions, response);
    return handler.next(response);
  }

  checkStatusCode(
    RequestOptions requestOptions,
    Response? response
  ){
    try {
        switch(response?.statusCode){
          case 200:
          case 204:
          case 201:
            break;
          case 400:
            throw BadRequestException(requestOptions, response);
          case 401:
            throw UnAuthorizedException(requestOptions);
          case 404:
            throw NotFoundException(requestOptions);
          case 409:
            throw ConflictException(requestOptions, response);
          case 500:
            throw InternalServerErrorException(requestOptions);
          default:
            throw ServerCommunicationException(response);
        }
    } on Failure {
        rethrow;
    }
  }

  

}