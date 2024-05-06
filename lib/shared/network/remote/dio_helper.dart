import 'package:dio/dio.dart';

class DioHelper {

  static late Dio dio ;

  static dioInit()
  {
    dio= Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
      )
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queries,
    String? lang = 'en',
    String? token,
  }) async
  {
    dio.options.headers=
    {
      'contentType': 'application/json',
      'lang' : lang,
      'Authorization' : token ?? '',
    };
    return await dio.get(
      path,
      queryParameters: queries,
    );
  }

  static Future<Response> postData({
    required String path,
    required data,
    Map<String, dynamic>? queries,
    String? lang = 'en' ,
    String? token,
  }) async
  {
    dio.options.headers=
    {
      'lang' : lang,
      'contentType': 'application/json',
      'Authorization' : token
    };
    return await dio.post(path, data: data, queryParameters: queries) ;
  }
}