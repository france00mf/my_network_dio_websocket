
import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/exceptions/bad_request_exception.dart';
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
              )
            }
        }

    super.onError(err, handler);
  }

}