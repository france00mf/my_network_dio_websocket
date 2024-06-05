
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


}