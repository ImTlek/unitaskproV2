part of 'login.cubit.dart';

class LoginState extends Equatable {
  final bool success;
  final bool error;
  final String message;
  final bool init;
  final bool loading;
  // final UserModel? userModel;

  const LoginState({
    required this.success,
    required this.error,
    required this.message,
    required this.init,
    required this.loading,
    // this.userModel
    // this.session,
  });

  @override
  List<Object> get props => [
        success,
        error,
        message,
        init,
        loading,

        // userModel ?? ''
        // session ?? 'nil',
      ];

  factory LoginState.loding() => const LoginState(
      error: false,
      init: false,
      loading: true,
      message: 'loding',
      success: false);
  factory LoginState.error(Object e) => LoginState(
      error: true,
      init: false,
      loading: false,
      message: e.toString(),
      success: false);
  factory LoginState.success(
          // UserModel u,
          ) =>
      const LoginState(
        error: false,
        init: false,
        loading: false,
        message: 'success',
        success: true,
        // userModel: u
        // session: s,
      );
  factory LoginState.init() => const LoginState(
      error: false,
      init: true,
      loading: false,
      message: 'init',
      success: false);
}
