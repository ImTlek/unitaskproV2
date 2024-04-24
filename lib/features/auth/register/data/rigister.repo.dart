// import 'package:flutter/cupertino.dart';
// import 'package:tanrtau/utils/dio/dio.dart';
// import 'package:tanrtau/services/auth/auth.dart';
// import 'package:tanrtau/feature/auth/model/user.dart';

// @immutable
// class RigisterRepository {
//   Future<UserModel> register(
//       {required String login,
//       required String password,
//       required String name}) async {
//     try {
//       var res = await _http.post(
//         'auth/user/register',
//         data: {'login': login, 'password': password, 'name': name},
//       );
//       var userModel = UserModel.fromJson(res.data['data']['user']);
//       await AuthService.I().setAuth(
//           accessToken: res.data['data']['accessToken'],
//           refreshToken: userModel.refreshToken,
//           userModel: userModel);

//       return userModel;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   THttp get _http => THttp.I();
// }
