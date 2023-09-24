
import 'package:dio/dio.dart';

import '../../models/requests/products/products_request_model.dart';
import '../../models/responses/products/products_response_model.dart';
import '../../services/api_helper.dart';
import '../../services/constant_endpoint.dart';

abstract class ProductsRepository{
  Future<List<ProductsResponseModel>> getAllProducts({int? limit, String? sort});
  Future<ProductsResponseModel> getDetailProducts({int? id});
  Future<ProductsResponseModel> createProduct({required ProductsRequestModel data});
  Future<ProductsResponseModel> updateProduct({required int id, required ProductsRequestModel data});
  Future<dynamic> deleteProduct({required int id});
}

class ProductsRepositoryImpl extends ProductsRepository{

  ApiHelper? _apiHelper;
  ApiHelper? get apiHelper => _apiHelper;

  static ProductsRepositoryImpl? _instance;
  static ProductsRepositoryImpl? get instance => _instance;

  factory ProductsRepositoryImpl({required ApiHelper apiHelper}){
    if (_instance != null) return _instance!;

    _instance = ProductsRepositoryImpl._(apiHelper: apiHelper);
    return _instance!;
  }

  ProductsRepositoryImpl._({required ApiHelper apiHelper}){
    _apiHelper = apiHelper;
  }

  @override
  Future<List<ProductsResponseModel>> getAllProducts({int? limit, String? sort}) async{
    try {
      final responseRaw = await _apiHelper?.get(endpoint: "${ConstantEndpoint.products}?limit=${limit}&sort=${sort}");
      
      final response = (responseRaw as List<dynamic>).map((data) => ProductsResponseModel.fromJson(data)).toList();

      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }

  @override
  Future<ProductsResponseModel> getDetailProducts({int? id}) async{
    try {
      final responseRaw = await _apiHelper?.get(endpoint: "${ConstantEndpoint.products}/$id");
      
      final response = ProductsResponseModel.fromJson(responseRaw);

      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }
  
  @override
  Future<ProductsResponseModel> createProduct({required ProductsRequestModel data}) async{
    try {
      final responseRaw = await _apiHelper?.post(endpoint: ConstantEndpoint.products);
      
      final response = ProductsResponseModel.fromJson(responseRaw);

      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }
  
  @override
  Future deleteProduct({required int id}) async{
    try {
      final responseRaw = await _apiHelper?.delete(endpoint: "${ConstantEndpoint.products}/$id");
      
      return responseRaw;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }
  
  @override
  Future<ProductsResponseModel> updateProduct({required int id, required ProductsRequestModel data}) async{
    try {
      final responseRaw = await _apiHelper?.put(endpoint: "${ConstantEndpoint.products}/$id", data: data.toJson());
      
      final response = ProductsResponseModel.fromJson(responseRaw);

      return response;
    } on DioException catch (e){
      throw Exception("${e.response?.statusMessage}(${e.response?.statusCode})");
    } catch (e){
      rethrow;
    }
  }

}