import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

void showDToast(Object? str) => showToast(
      '$str',
      position: const ToastPosition(align: Alignment.bottomCenter, offset: 5),
    );
