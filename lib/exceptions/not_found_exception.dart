import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/failure.dart';

class NotFoundException extends DioException implements Failure{
  NotFoundException({required super.requestOptions});

  @override
  // TODO: implement title
  String get title => throw UnimplementedError();
  
}