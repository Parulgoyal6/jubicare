import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jublicare/bloc/login/login_event.dart';
import 'package:jublicare/bloc/login/login_state.dart';

import '../../data/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  final AuthRepository authRepository;


  LoginBloc(this.authRepository) : super(LoginInitial()){
    on<LoginSubmitted>(_onLoginSubmitted);


  }

  Future<void>_onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginState>emit,
      )async{
    emit(LoginLoading());

    try{
      final result =  await authRepository.login(
        event.username,
        event.password
      );
      emit(LoginSuccess(result));
    }catch(e){
      emit(LoginFailure(e.toString()));
    }
  }
}