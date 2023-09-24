
import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    options.headers = {
      "Content-Type": Headers.jsonContentType,
    };    

    print("========== REQUEST ==========");
    print("BASE URL      : ${options.baseUrl}");
    print("ENDPOINT      : ${options.path}");
    print("METHOD        : ${options.method}");
    print("HEADERS       : ${options.headers}");
    print("REQUEST DATA  : ${options.data}");

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("========== RESPONSE ==========");
    print("BASE URL      : ${response.requestOptions.baseUrl}");
    print("ENDPOINT      : ${response.requestOptions.path}");
    print("METHOD        : ${response.requestOptions.method}");
    print("HEADERS       : ${response.headers}");
    print("STATUS CODE   : ${response.statusCode}");
    print("RESPONSE DATA : ${response.data}");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("========== ERROR ==========");
    print("ERROR         : ${err}");
    return super.onError(err, handler);
  }
  
}