part of 'rigister_cubit.dart';

class RigisterState extends Equatable {
  final bool success;
  final bool error;
  final String message;
  final bool init;
  final bool loading;
  // final User? account;
  // final UserModel? userModel;

  const RigisterState({
    required this.success,
    required this.error,
    required this.message,
    required this.init,
    required this.loading,
    // this.userModel
    // this.account,
  });

  @override
  List<Object> get props => [
        success,
        error,
        message,
        init,
        loading,
        // userModel ?? '',
      ];

  factory RigisterState.loding() => const RigisterState(
      error: false,
      init: false,
      loading: true,
      message: 'loding',
      success: false);
  factory RigisterState.error(Object e) => RigisterState(
      error: true,
      init: false,
      loading: false,
      message: e.toString(),
      success: false);
  factory RigisterState.success(
          // UserModel u,
          ) =>
      const RigisterState(
        error: false,
        init: false,
        loading: false,
        message: 'success',
        success: true,
        // userModel: u
        // account: u,
      );
  factory RigisterState.init() => const RigisterState(
      error: false,
      init: true,
      loading: false,
      message: 'init',
      success: false);
}
