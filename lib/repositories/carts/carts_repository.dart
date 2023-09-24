
import 'package:dio/dio.dart';
import 'package:fake_store/models/responses/carts/carts_response_model.dart';

import '../../models/requests/carts/carts_request_model.dart';
import '../../services/api_helper.dart';
import '../../services/constant_endpoint.dart';

abstract class CartsReporsitory{
  Future<List<CartsResponseModel>> getAllCarts();
  Future<CartsResponseModel> getDetailCarts({required int id});
  Future<CartsResponseModel> createCarts({required CartsRequestModel data});
  Future<CartsResponseModel> updateCarts({required int id, required CartsRequestModel data});
  Future<dynamic> deleteCarts({required int id});
}

class CartsReporsitoryImpl extends CartsReporsitory{
  ApiHelper? _apiHelper;
  ApiHelper? get apiHelper => _apiHelper;

  static CartsReporsitoryImpl? _instance;
  static CartsReporsitoryImpl? get instance => _instance;

  factory CartsReporsitoryImpl({required ApiHelper apiHelper}){
    if (_instance != null) return _instance!;

    _instance = CartsReporsitoryImpl._(apiHelper: apiHelper);
    return _instance!;
  }

  CartsReporsitoryImpl._({required ApiHelper apiHelper}){
    _apiHelper = apiHelper;
  }
  
  @override
  Future<List<CartsResponseModel>> getAllCarts() async{
    try {
      final responseRaw = await _apiHelper?.get(endpoint: ConstantEndpoint.carts);
      
      final response = (responseRaw as List<dynamic>).map((data) => CartsResponseModel.fromJson(data)).toList();

      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }
  
  @override
  Future<CartsResponseModel> getDetailCarts({required int id}) async{
    try {
      final responseRaw = await _apiHelper?.get(endpoint: "${ConstantEndpoint.carts}/$id");
      
      final response = CartsResponseModel.fromJson(responseRaw);

      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }
  
  @override
  Future<CartsResponseModel> createCarts({required CartsRequestModel data}) async{
    try {
      final responseRaw = await _apiHelper?.post(endpoint: ConstantEndpoint.carts, data: data.toJson());
      
      final response = CartsResponseModel.fromJson(responseRaw);

      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }
  
  @override
  Future<CartsResponseModel> updateCarts({required int id, required CartsRequestModel data}) async{
    try {
      final responseRaw = await _apiHelper?.put(endpoint: "${ConstantEndpoint.carts}/$id", data: data.toJson());
      
      final response = CartsResponseModel.fromJson(responseRaw);

      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }
  
  @override
  Future deleteCarts({required int id}) async{
    try {
      final responseRaw = await _apiHelper?.delete(endpoint: "${ConstantEndpoint.carts}/$id");
      
      return responseRaw;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }

}