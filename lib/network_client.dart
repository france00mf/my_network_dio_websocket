
import 'dart:io';

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

final Dio _dio = _createDio();
Dio get dio => _dio;

Future<dynamic> sendFormData({
  FormDataType requestType,
  required String uri,
  Map<String, File> images= const {},
  required Map<String, dynamic> body ,
  // Map<>
})async{
   try{
    Map<String, MultipartFile> multipartImages={};
    await Future.forEach<MapEntry<String, File>>(images.entries, (element) async {
      multipartImages[element.key] = await MultipartFile.fromFile(element.value.path);
    });

    FormData formData = FormData.fromMap({...body, ...multipartImages});
    if(FormData.patch == requestType){
      response = await _dio.patch();
    }
   }catch{

   } 
}

