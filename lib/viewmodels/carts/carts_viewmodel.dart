
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/requests/carts/carts_request_model.dart';
import '../../repositories/carts/carts_repository.dart';

abstract class CartsState{
  String? error;
  dynamic data;
}

class CartsInitialState extends CartsState{}
class CartsLoadingState extends CartsState{}
class CartsLoadedState extends CartsState{
  CartsLoadedState({dynamic data, String? error}){
    super.data = data;
    super.error = error;
  }
}
class CartsFailedState extends CartsState{
  CartsFailedState({dynamic data, String? error}){
    super.data = data;
    super.error = error;
  }
}

class CartsCubit extends Cubit<CartsState>{
  final CartsReporsitory repo;

  CartsCubit({required this.repo}): super(CartsInitialState());

  getAllCarts() async{
    try {
      emit(CartsLoadingState());

      final response = await repo.getAllCarts();

      emit(CartsLoadedState(data: response));

    } catch (e){
      emit(CartsFailedState(error: e.toString()));
    }
  }

  getDetailCarts({required int id}) async{
    try {
      emit(CartsLoadingState());

      final response = await repo.getDetailCarts(id: id);

      emit(CartsLoadedState(data: response));

    } catch (e){
      emit(CartsFailedState(error: e.toString()));
    }
  }

  createCarts({required CartsRequestModel data}) async{
    try {
      emit(CartsLoadingState());

      final response = await repo.createCarts(data: data);

      emit(CartsLoadedState(data: response));

    } catch (e){
      emit(CartsFailedState(error: e.toString()));
    }
  }

  updateCarts({required int id, required CartsRequestModel data}) async{
    try {
      emit(CartsLoadingState());

      final response = await repo.updateCarts(id: id, data: data);

      emit(CartsLoadedState(data: response));

    } catch (e){
      emit(CartsFailedState(error: e.toString()));
    }
  }

  deleteCarts({required int id}) async{
    try {
      emit(CartsLoadingState());

      final response = await repo.deleteCarts(id: id);

      emit(CartsLoadedState(data: response));

    } catch (e){
      emit(CartsFailedState(error: e.toString()));
    }
  }
}