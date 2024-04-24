// import 'package:flutter/material.dart'; 
// import 'package:google_sign_in/google_sign_in.dart';

// @immutable
// class LoginRepository {
//   Future<UserModel> login(
//       {required String login, required String password}) async {
//     try {
//       var response = await _http.post(
//         'auth/user/login',
//         data: {
//           "login": login.replaceAll(' ', ''),
//           "password": password.replaceAll(' ', '')
//         },
//       );
//       var userModel = UserModel.fromJson(response.data['data']['user']);
//       await AuthService.I().setAuth(
//           accessToken: response.data['data']['accessToken'],
//           refreshToken: userModel.refreshToken,
//           userModel: userModel);
//       return userModel;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<UserModel> loginWithOAuth() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       var authentication = await googleUser?.authentication;

//       var res = await _http.post('auth/user/googleAuth',
//           data: authentication?.idToken);

//       var userModel = UserModel.fromJson(res.data['data']['user']);
//       await AuthService.I().setAuth(
//           accessToken: res.data['data']['accessToken'],
//           refreshToken: userModel.refreshToken,
//           userModel: userModel);

//       return userModel;
//     } catch (e) {
//       rethrow;
//     } finally {
//       GoogleSignIn().signOut();
//     }
//   }

//   THttp get _http => THttp.I();
// }
