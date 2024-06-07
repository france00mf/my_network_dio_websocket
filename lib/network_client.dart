
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  dio.interceptors.add(NetworkServiceInterceptors(
    dio,
    errorKey: 'message'
  ));
  return dio;
}

enum FormDataType{post, patch}

class NetWorkClient{

final Dio _dio = _createDio();
Dio get dio => _dio;


final Map<String, dynamic> _headers={};

  Future<T> get<T>(
       String uri,
    {
    Map<String, dynamic>? requestHeaders,
  Map<String, File> images= const {},
  Map<String, File> queryParameters= const {},
  CancelToken? cancelToken,
  ProgressCallback? onReceiveProgress,
  }) async{
    try{
      Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options( headers: requestHeaders ?? {})
      );  
      return response.data;
    } on Failure{
      rethrow;
    }
  }

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

 Future<dynamic> post(
    
    String uri, {

    Map<String, dynamic> queryParameters = const {},
    Object? body,
    Map<String, dynamic>? requestHeaders,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await _dio.post(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      
      return response.data;
    } on Failure {
      rethrow;
    }
  }


    Future<T> put<T>(
    
    String uri, {

    Map<String, dynamic> queryParameters = const {},
    Object body = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? requestHeaders,
  }) async {
    try {
      Response response = await _dio.put(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      
      return response.data;
    } on Failure {
      rethrow;
    }
  }


  Future<T> patch<T>(
    
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Object body = const {},
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? requestHeaders,
  }) async {
    try {
      Response response = await _dio.patch(
        uri,
        queryParameters: queryParameters,
        data: body,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      return response.data;
    } on Failure {
      rethrow;
    }
  }

    Future<T> delete<T>(
    String uri, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic>? requestHeaders,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.delete(
        uri,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(
          headers: requestHeaders ?? _headers,
        ),
      );
      return response.data;
    } on Failure {
      rethrow;
    }
  }


   Future<dynamic> sendArrayImagesFormData(
    FormDataType requestType, {
    required String uri,
    Map<String, dynamic> queryParameters = const {},


    List<File> images = const [],
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var tempList = [];
      for (var i = 0; i < images.length; i++) {
        var item = images[i];
        var multipartFile = await MultipartFile.fromFile(
          item.path,
          
        );
        tempList.add(multipartFile);
      }

      FormData formData = FormData.fromMap(
        {
          'images': tempList,
        },
      );
      Response response;
      if (FormDataType.patch == requestType) {
        response = await _dio.patch(
          uri,
          queryParameters: queryParameters,
          data: formData,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: Options(
            headers: _headers,
          ),
        );
      } else {
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
    } on Failure {
      rethrow;
    }
  }

}

  final networkClientProvider = Provider<NetWorkClient>(
    (ref) => NetWorkClient(),
  );




