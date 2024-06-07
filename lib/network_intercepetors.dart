
import 'package:dio/dio.dart';
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

            }
        }

    super.onError(err, handler);
  }

}