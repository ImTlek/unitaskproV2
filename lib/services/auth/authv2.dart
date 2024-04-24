import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class DpAuth {
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  static final DpAuth _instance = _AuthImpl();
  static DpAuth get instance => _instance;
  static DpAuth get I => _instance;

  User? _currentLoginModel;
  late Stream<bool> _streamIsLoggedIn;
  late StreamController<User?> _loginController;

  bool get isLoggedIn => _instance._currentLoginModel != null;
  User? get currentLoginModel => _instance._currentLoginModel;
  Stream<bool> get streamIsLoggedIn => _instance._streamIsLoggedIn;
  Future<void> init();
  Future<void> logout();
  Future<void> login(User model);
  Future<void> updateLogin(
      {required String refreshToken, required String accessToken});
  void close();
}

final class _AuthImpl extends DpAuth {
  @override
  Stream<bool> get _streamIsLoggedIn =>
      _auth.userChanges().map((event) => event != null);

  // _loginController.stream.map((user) => user != null);

  @override
  Future<void> init() async {
    // var loginModel = await SPStorage.getLoginModel();
    // _currentLoginModel = loginModel != null
    //     ? LoginModel.fromJson(Map.from(loginModel))
    //     : LoginModel.none;
    _loginController = StreamController<User?>.broadcast(
        onListen: () => _emitLogin(_currentLoginModel));
    _streamIsLoggedIn = _loginController.stream.map((user) => user != null);
  }

  @override
  Future<void> login(User model) async => _emitLogin(model);

  @override
  Future<void> logout() async {
    // await JpHive.clearAll();
    _emitLogin(null);
  }

  @override
  Future<void> updateLogin(
          {required String refreshToken, required String accessToken}) =>
      _saveLoginModel(currentLoginModel);

  void _emitLogin(User? model) async {
    await _saveLoginModel(model);
    _currentLoginModel = model;
    _loginController.add(_currentLoginModel);
  }

  Future<void> _saveLoginModel(User? model) async {
    try {
      _currentLoginModel = model;
      // if (model != LoginModel.none) {
      //   await JpHive.writeValue<Map>(AppKey.LOGINKEY, model.toJson());
      //   await SPStorage.write(accessToken, model.token);
      //   await SPStorage.write(refreshToken, model.refreshToken);
      //   await SPStorage.write(guid, model.uid);
      // } else {
      //   await SPStorage.delete(accessToken);
      //   await SPStorage.delete(refreshToken);
      //   await SPStorage.delete(guid);
      //   await JpHive.deleteValue(AppKey.LOGINKEY);
      // }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void close() => _loginController.close();
}
