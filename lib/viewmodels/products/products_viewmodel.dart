import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/requests/products/products_request_model.dart';
import '../../repositories/products/products_repository.dart';

abstract class ProductsState{
  String? error;
  dynamic data;
}

class ProductsInitialState extends ProductsState{}
class ProductsLoadingState extends ProductsState{}
class ProductsLoadedState extends ProductsState{
  ProductsLoadedState({dynamic data, String? error}){
    super.data = data;
    super.error = error;
  }
}
class ProductsFailedState extends ProductsState{
  ProductsFailedState({dynamic data, String? error}){
    super.data = data;
    super.error = error;
  }
}

class ProductsCubit extends Cubit<ProductsState>{
  final ProductsRepository repo;

  ProductsCubit({required this.repo}): super(ProductsInitialState());

  getAllProducts({int? limit, String? sort}) async{
    try {
      emit(ProductsInitialState());

      final response = await repo.getAllProducts(limit: limit, sort: sort);

      emit(ProductsLoadedState(data: response));

    } catch (e){
      emit(ProductsFailedState(error: e.toString()));
    }
  }

  getDetailProduct({required int id}) async{
    try {
      emit(ProductsInitialState());

      final response = await repo.getDetailProducts(id: id);

      emit(ProductsLoadedState(data: response));

    } catch (e){
      emit(ProductsFailedState(error: e.toString()));
    }
  }

  createProduct({required ProductsRequestModel data}) async{
    try {
      emit(ProductsInitialState());

      final response = await repo.createProduct(data: data);

      emit(ProductsLoadedState(data: response));

    } catch (e){
      emit(ProductsFailedState(error: e.toString()));
    }
  }

  updateProduct({required int id, required ProductsRequestModel data}) async{
    try {
      emit(ProductsInitialState());

      final response = await repo.updateProduct(id: id, data: data);

      emit(ProductsLoadedState(data: response));

    } catch (e){
      emit(ProductsFailedState(error: e.toString()));
    }
  }

  deleteProduct({required int id}) async{
    try {
      emit(ProductsInitialState());

      final response = await repo.deleteProduct(id: id);

      emit(ProductsLoadedState(data: response));

    } catch (e){
      emit(ProductsFailedState(error: e.toString()));
    }
  }
}
