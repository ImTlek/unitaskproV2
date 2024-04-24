import 'package:flutter/material.dart';
import 'package:unitaskpro/l10n/lan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';
import 'package:unitaskpro/features/auth/register/cubit/rigister_cubit.dart';

@immutable
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var themeData = Theme.of(context);
    var localizations = AppLocalizations.of(context)!;

    var sizeOf = MediaQuery.sizeOf(context);

    return ScaffoldWidget(
      appBar: AppBarWidget(title: localizations.tRigister),
      body: UnfocusWidget(
        child: BlocProvider(
          create: (context) => RigisterCubit(),
          lazy: true,
          child: Builder(builder: (context) {
            var cubit = context.read<RigisterCubit>();
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                SizedBox(height: sizeOf.height * .2),
                verticalMargin24,
                Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      TextFiledWidget(
                        label: localizations.tEmai,
                        textInputAction: TextInputAction.next,
                        onChanged: (n) {
                          cubit.onInfoChanges(login: n);
                        },
                      ),
                      verticalMargin16,
                      // TextFiledWidget(
                      //   label: localizations.tEmai,
                      //   keyboardType: TextInputType.emailAddress,
                      //   textInputAction: TextInputAction.next,
                      //   inputFormatters: const [
                      //     // PhoneInputFormatter(
                      //     //     mask: "+7##########",
                      //     //     filter: {"#": RegExp(r'[0-9]')},
                      //     //     type: MaskAutoCompletionType.eager)
                      //   ],
                      //   onChanged: (e) {
                      //     cubit.onInfoChanges(login: e);
                      //   },
                      // ),
                      // verticalMargin16,
                      PasswordTextField(
                        textInputAction: TextInputAction.next,
                        label: localizations.tPassword,
                        onChanged: (p) {
                          cubit.onInfoChanges(password: p);
                        },
                      ),
                      verticalMargin16,
                      PasswordTextField(
                        textInputAction: TextInputAction.done,
                        label: localizations.tRepeatPassword,
                        onChanged: (p) {
                          cubit.onInfoChanges(conPassword: p);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ValueListenableBuilder(
                  valueListenable: cubit.disabled,
                  builder: (context, disabled, child) =>
                      BlocConsumer<RigisterCubit, RigisterState>(
                    listener: (context, state) {
                      if (state.success) {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(builder: (c) => const AppMain()),
                        //     (s) => false);
                      }
                    },
                    builder: (context, state) {
                      return IgnorePointer(
                        ignoring: state.loading,
                        child: Column(
                          children: [
                            LoadingBtnWidget(
                              disabled: !disabled,
                              onTap: cubit.rigister,
                              loading: state.loading,
                              title: localizations.tRigister,
                              // bgColor: themeData.primaryColor
                              // AppTheme.mainColor,
                            ),
                            verticalMargin16,

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Checkbox(
                            //         fillColor: MaterialStateProperty.all(
                            //             themeData.primaryColor),
                            //         shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(4)),
                            //         value: disabled,
                            //         onChanged: (b) {
                            //           cubit.disabled.value = b!;
                            //         }),
                            //     BtnWidget(
                            //       onTap: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //               builder: (context) =>
                            //                   const TermsPage(),
                            //             ));
                            //       },
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(6.0),
                            //         child: Row(
                            //           children: [
                            //             Text(localizations.tTermsandconditions),
                            //             horizontalMargin12,
                            //             const Icon(Icons.arrow_right)
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
