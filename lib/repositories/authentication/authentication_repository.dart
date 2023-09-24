
import 'package:dio/dio.dart';
import 'package:fake_store/models/requests/authentication/authentication_request_model.dart';
import 'package:fake_store/services/api_helper.dart';
import 'package:fake_store/services/constant_endpoint.dart';

import '../../models/responses/authentication/authentication_response_model.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationResponseModel> login({required AuthenticationRequestModel model});
}

class AuthenticationRepositoryImpl extends AuthenticationRepository{
  ApiHelper? _apiHelper;
  ApiHelper? get apiHelper => _apiHelper;

  static AuthenticationRepositoryImpl? _instance;
  static AuthenticationRepositoryImpl? get instance => _instance;

  factory AuthenticationRepositoryImpl({required ApiHelper apiHelper}){
    if (_instance != null) return _instance!;

    _instance = AuthenticationRepositoryImpl._(apiHelper: apiHelper);
    return _instance!;
  }

  AuthenticationRepositoryImpl._({required ApiHelper apiHelper}){
    _apiHelper = apiHelper;
  }

  @override
  Future<AuthenticationResponseModel> login({required AuthenticationRequestModel model}) async{
    try {
      
      final responseRaw = await _apiHelper?.post(endpoint: ConstantEndpoint.login, data: model.toJson());
      final response = AuthenticationResponseModel.fromJson(responseRaw);
      
      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }
  
}