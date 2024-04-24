import 'package:unitaskpro/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitaskpro/services/auth/auth.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
part 'login.state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.init());

  // final LoginRepository _repository;
  late String _login;
  late String _password;
  //------------------------------------------------
  //------------------------------------------------

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  void onInfoChanges({String? l, String? p}) {
    if (l != null) {
      _login = l;
    }
    if (p != null) {
      _password = p;
    }
  }

  // late final AuthService authService = AuthService();

  void login() async {
    try {
      if (_formKey.currentState!.validate()) {
        emit(LoginState.loding());
        await authService.login(email: _login, password: _password);

        emit(LoginState.success());
      }
    } catch (e) {
      onError(e, StackTrace.current);
    }
  }

  void loginWithOAuth(String provider) async {
    emit(LoginState.loding());
    try {
      // var user = await _repository.loginWithOAuth();
      emit(LoginState.success());
    } catch (e) {
      onError(e, StackTrace.current);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(LoginState.error(error));

    logs(error);

    showDToast(error);

    super.onError(error, stackTrace);
  }
}
