
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_network_dio_websocket/errors/failure.dart';
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

final Dio _dio = _createDio();
Dio get dio => _dio;

enum FormDataType{post, patch}
final Map<String, dynamic> _headers={};

Future<dynamic> sendFormData(FormDataType requestType,{
  
  required String uri,
  Map<String, File> images= const {},
  required Map<String, dynamic> body ,
  Map<String, File> queryParameters= const {},
  CancelToken? cancelToken,
  ProgressCallback? onReceiveProgress,
  // Map<>
})async{
   try{
    Map<String, MultipartFile> multipartImages={};
    await Future.forEach<MapEntry<String, File>>(images.entries, (element) async {
      multipartImages[element.key] = await MultipartFile.fromFile(element.value.path);
    });

    FormData formData = FormData.fromMap({...body, ...multipartImages});
    Response response;
    if(FormDataType.patch == requestType){
      response = await _dio.patch(
        uri,
        queryParameters: queryParameters,
        data: formData,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: _headers,
        )
      );
    } else{
      response = await _dio.post(
        uri,
        queryParameters: queryParameters,
        data: formData,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(headers: _headers),
      );
    }
    return response.data;
   }on Failure{
    rethrow;
   } 
}

