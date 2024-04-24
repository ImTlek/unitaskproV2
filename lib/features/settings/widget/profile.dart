import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

@immutable
class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    var user = FirebaseAuth.instance.currentUser;
    return Card(
        margin: const EdgeInsets.all(12),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.email ?? 'Email',
                            style: themeData.textTheme.titleLarge,
                          ),
                          // Text(

                          //        user?.uid ?? 'Email',
                          //   'Update youre photo and personal information here',
                          //   style: themeData.textTheme.labelLarge,
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeData.colorScheme.primaryContainer,
                          border: Border.all(
                              color: themeData.colorScheme.inversePrimary)),
                      height: 55,
                      width: 55,
                      alignment: Alignment.center,
                      child: Text(
                        user?.email?[0] ?? 'Email'[0],
                        style: themeData.textTheme.titleLarge,
                      ),
                    )
                  ],
                ),
                // verticalMargin12,
                // _fild('Name'),
                // verticalMargin12,
                // _fild('Last name'),
                // verticalMargin12,
                // _fild('Email'),
              ],
            )));
  }
}

Widget _fild(String title) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(title), verticalMargin8, const FiledWidget()]);
}
