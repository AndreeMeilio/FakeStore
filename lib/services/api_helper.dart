
import 'package:dio/dio.dart';

import 'constant_endpoint.dart';
import 'custom_interceptors.dart';

class ApiHelper{

  final Dio _dio = Dio();

  static ApiHelper? _instance;
  static ApiHelper? get instance => _instance;
  
  factory ApiHelper(){
    if (_instance != null) return _instance!;

    _instance = ApiHelper._();
    return _instance!;
  }

  ApiHelper._(){
    _dio.options.baseUrl = ConstantEndpoint.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 120);
    _dio.options.receiveTimeout = const Duration(seconds: 120);
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<dynamic> get({required String endpoint, Map<String, dynamic>? data}) async{
    try{
      final response = await _dio.get(endpoint, data: data);

      return response.data;
    } catch (e){
      rethrow;
    }
  }

  Future<dynamic> post({required String endpoint, Map<String, dynamic>? data}) async{
    try{
      final response = await _dio.post(endpoint, data: data);

      return response.data;
    } catch (e){
      
      rethrow;
    }
  }

  Future<dynamic> put({required String endpoint, Map<String, dynamic>? data}) async{
    try{
      final response = await _dio.put(endpoint, data: data);

      return response.data;
    } catch (e){
      
      rethrow;
    }
  }

  Future<dynamic> delete({required String endpoint, Map<String, dynamic>? data}) async{
    try{
      final response = await _dio.delete(endpoint, data: data);

      return response.data;
    } catch (e){
      
      rethrow;
    }
  }
}