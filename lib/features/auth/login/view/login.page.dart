import 'package:flutter/material.dart';
import 'package:unitaskpro/l10n/lan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
import 'package:unitaskpro/features/auth/login/cubit/login.cubit.dart';

@immutable
class LoginPage extends StatelessWidget {
  const LoginPage({super.key, this.login, this.password});

  final String? password;
  final String? login;
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context)!;
    // var themeData = Theme.of(context);
    var size = MediaQuery.sizeOf(context);
    return BlocProvider(
      lazy: true,
      create: (context) => LoginCubit(),
      child: ScaffoldWidget(
          appBar: AppBarWidget(title: localizations.tLogin),
          body: UnfocusWidget(
            child: Builder(builder: (context) {
              var cubit = context.read<LoginCubit>();
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  if (password != null && login != null) {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      cubit.onInfoChanges(l: login, p: password);
                      cubit.login();
                    });
                  }
                },
              );
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  verticalMargin24,
                  Column(
                    children: [
                      Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            SizedBox(height: size.height * .2),
                            TextFiledWidget(
                              textInputAction: TextInputAction.next,
                              label: localizations.tEmai,
                              initStr: login,
                              onChanged: (e) {
                                cubit.onInfoChanges(l: e);
                              },
                            ),
                            const SizedBox(height: 20),
                            PasswordTextField(
                              textInputAction: TextInputAction.done,
                              label: localizations.tPassword,
                              initStr: password,
                              onChanged: (p) {
                                cubit.onInfoChanges(p: p);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return IgnorePointer(
                            ignoring: state.loading,
                            child: Column(
                              children: [
                                LoadingBtnWidget(
                                  onTap: cubit.login,
                                  loading: state.loading,
                                  title: localizations.tLogin,
                                  // bgColor: themeData.primaryColor,
                                ),
                                verticalMargin16,
                                // BtnWidget(
                                //   onTap: () {},
                                //   child: Text(
                                //     localizations.tForgetPassword,
                                //     textAlign: TextAlign.center,
                                //     style: const TextStyle(
                                //         fontSize: 18,
                                //         color: Color(0xff909090),
                                //         fontWeight: FontWeight.w400),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  verticalMargin16,
                  // if (Platform.isAndroid)
                  //   Column(
                  //     children: [
                  //       const Row(
                  //         children: [
                  //           Expanded(child: Divider()),
                  //           Padding(
                  //             padding: EdgeInsets.all(8.0),
                  //             child: Text('OR'),
                  //           ),
                  //           Expanded(child: Divider()),
                  //         ],
                  //       ),
                  //       verticalMargin16,
                  //       BtnWidget(
                  //         onTap: () {
                  //           cubit.loginWithOAuth('google');
                  //         },
                  //         child: Container(
                  //             height: 44,
                  //             width: 44,
                  //             padding: const EdgeInsets.all(10),
                  //             margin:
                  //                 const EdgeInsets.symmetric(horizontal: 10),
                  //             alignment: Alignment.center,
                  //             decoration: BoxDecoration(
                  //               color: themeData.splashColor,
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             child: Image.asset('assets/images/goolge.png')),
                  //       ),
                  //     ],
                  //   ),
                ],
              );
            }),
          )),
    );
  }
}

// void whatsapp() async {
//   var contact = "7712062119";
//   var androidUrl =
//       "whatsapp://send?phone=$contact&text=Құпия сөзді ұмытып қалдым";
//   var iosUrl =
//       "https://wa.me/$contact?text=${Uri.parse('Құпия сөзді ұмытып қалдым')}";

//   if (Platform.isIOS) {
//     await launchUrl(Uri.parse(iosUrl));
//   } else {
//     await launchUrl(Uri.parse(androidUrl));
//   }
// }
