// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthRepo {
//   AuthRepo._();

//   late final FirebaseAuth _auth = FirebaseAuth.instance;

//   Timer? _saveTimer;
//   late StreamController<User?> _userController;

//   Stream<User?> get streamUser => _userController.stream;
//   User? get _currentUser => _auth.currentUser;

//   User? get currentUser => _auth.currentUser; //_currentUser;

//   Stream<bool> get streamIsLoggedIn => _userController.stream //
//       .map((user) => user != null);

//   bool get isLoggedIn => _auth.currentUser != null;

//   static Future<AuthRepo> create() async {
//     var currentUser = FirebaseAuth.instance;
//     // User currentUser;
//     // File file;
//     // try {
//     //   final dir = await path_provider.getApplicationDocumentsDirectory();
//     //   file = File(path.join(dir.path, 'user.json'));
//     // } catch (error, stackTrace) {
//     //   print('$error\n$stackTrace'); // Send to server?
//     //   rethrow;
//     // }
//     // try {
//     //   if (await file.exists()) {
//     //     currentUser = User.fromJson(
//     //       json.decode(await file.readAsString()),
//     //     );
//     //   } else {
//     //     currentUser = User.none;
//     //   }
//     // } catch (error, stackTrace) {
//     //   print('$error\n$stackTrace'); // Send to server?
//     //   file.delete();
//     //   currentUser = User.none;
//     // }
//     return AuthRepo._()..init();
//   }

//   void init() {
//     _userController = StreamController<User>.broadcast(
//       onListen: () => _emitUser(_currentUser),
//     );
//   }

//   void _emitUser(User value) {
//     _currentUser = value;
//     _userController.add(value);
//     _saveUser();
//   }

//   Future<void> login(String username, String password) async {
//     try {
//       // final response = await _apiService.login(username, password);
//       // _accessToken = response.accessToken;
//       // _emitUser(User.fromDto(response.user));
//     } catch (error, stackTrace) {
//       print('$error\n$stackTrace');
//       // FIXME: show user error, change state? rethrow?
//     }
//   }

//   Future<void> logout() async {
//     try {
//       // await _apiService.logout();
//     } catch (error, stackTrace) {
//       print('$error\n$stackTrace');
//       // FIXME: failed to logout? report to server
//     }
//     // _emitUser(User.none);
//   }

//   void retrieveUser() {
//     // currentUser = apiService.fetchUser();
//     // _saveUser();
//   }

//   void _saveUser() {
//     _saveTimer?.cancel();
//     _saveTimer = Timer(const Duration(seconds: 1), () async {
//       // if (_currentUser == User.none) {
//       //   if (_file.existsSync()) {
//       //     await _file.delete();
//       //   }
//       // } else {
//       //   await _file.writeAsString(json.encode(_currentUser.toJson()));
//       // }
//     });
//   }
// }
