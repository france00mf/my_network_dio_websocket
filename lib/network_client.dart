
import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/network_intercepetors.dart';

String get _baseUrl{
 return "https://routex-demo.onrender.com";
}

Dio _createDio(){
  var dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 60),
      headers: {},
    )
  ) ;

  dio.interceptors.add(NetworkServiceInterceptors());
  return dio;
}