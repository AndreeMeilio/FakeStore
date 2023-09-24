
import 'package:fake_store/models/requests/authentication/authentication_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/authentication/authentication_repository.dart';

abstract class AuthenticationState{
  String? error;
  dynamic data;
}

class AuthenticationInitialState extends AuthenticationState{}
class AuthenticationLoadingState extends AuthenticationState{}
class AuthenticationLoadedState extends AuthenticationState{
  AuthenticationLoadedState({dynamic data, String? error}){
    super.data = data;
    super.error = error;
  }
}
class AuthenticationFailedState extends AuthenticationState{
  AuthenticationFailedState({dynamic data, String? error}){
    super.data = data;
    super.error = error;
  }
}

class AuthenticationCubit extends Cubit<AuthenticationState>{

  final AuthenticationRepository repo;
  AuthenticationCubit({required this.repo}): super(AuthenticationInitialState());

  login(AuthenticationRequestModel data) async{
    try {
      emit(AuthenticationLoadingState());

      final response = await repo.login(model: data);
      
      emit(AuthenticationLoadedState(data: response));
    } catch (e){
      print(e);
      emit(AuthenticationFailedState(error: e.toString()));
    }
  }

}