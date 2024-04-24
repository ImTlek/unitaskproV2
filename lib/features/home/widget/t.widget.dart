import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class LocalizedDateTimeDisplay extends StatelessWidget {
  const LocalizedDateTimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting('kk_KZ');
    final now = DateTime.now();
    final formattedDate =
        DateFormat.yMMMMd('kk_KZ').format(now); // Kazakh (kk) with KZ region
    final formattedTime =
        DateFormat.Hm().format(now); // 12-hour format with minutes

    return Text(
      '$formattedDate, $formattedTime ',
      style: const TextStyle(
        fontSize: 16.0,
        // color: Colors.white,
      ),
    );
  }
}
