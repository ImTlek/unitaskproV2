import 'package:unitaskpro/main.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitaskpro/services/auth/auth.dart';
import 'package:unitaskpro/features/shared/widget/toast.dart';

part 'rigister_state.dart';

class RigisterCubit extends Cubit<RigisterState> {
  RigisterCubit() : super(RigisterState.init());

  late String _login, _password, _conPassword;

  String get password => _password;
  String get login => _login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  final ValueNotifier<bool> _disabled = ValueNotifier(true);
  ValueNotifier<bool> get disabled => _disabled;

  void onInfoChanges(
      {
      // String? fullname,
      String? login,
      String? password,
      String? conPassword}) {
    // if (fullname != null) _fullname = fullname;
    if (login != null) _login = login;
    if (password != null) _password = password;
    if (conPassword != null) _conPassword = conPassword;
  }

  void rigister() {
    if (_formKey.currentState!.validate()) {
      if (_password == _conPassword) {
        if (_password.length > 7) {
          _rigister();
        } else {
          showDToast('Құпия сөз тым қысқа !');
        }
      } else {
        showDToast('Құпия сөз сәйкес емес !');
      }
    }
  }

  void _rigister() async {
    // var check = _nameCheck(_fullname);
    // if (check) {
    emit(RigisterState.loding());
    try {
      await authService.registration(email: _login, password: _password);
      emit(RigisterState.success());
      return;
    } catch (e) {
      onError(e, StackTrace.current);
    }
    // } else {
    // showDToast('Аты тым ұзын');
    // return;
    // }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    showDToast(error);
    emit(RigisterState.error(error));

    logs(error);
    super.onError(error, stackTrace);
  }

  @override
  Future<void> close() {
    _disabled.dispose();
    return super.close();
  }

  bool _nameCheck(String name) {
    if (name.isEmpty) {
      showDToast('Аты бос болмауы керек');
      return false;
    }
    var ok = name.length <= 14;

    return ok;
  }
}
