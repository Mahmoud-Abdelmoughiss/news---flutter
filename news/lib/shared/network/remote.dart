import 'package:dio/dio.dart';

class DioHelper{
  static  Dio dio;
  static init(){
    dio = Dio(BaseOptions(
      baseUrl: "https://newsapi.org/",
        receiveDataWhenStatusError: true,
        ///https://newsapi.org/v2/top-headlines?country=eg&apiKey=d6e9937c01d04b1d99a14aa9a0a39597
    ));
  }
  static Future<Response> getData(String url,Map<String, dynamic> query)async{
    return await dio.get(url,queryParameters: query);
  }
}