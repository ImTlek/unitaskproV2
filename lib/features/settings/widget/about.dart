import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unitaskpro/utils/ex.dart';
import 'package:unitaskpro/features/shared/widget/widget.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(context.local.laboutdescription),
              verticalMargin12,
              const Text(
                'Version : 0.1',
                style: TextStyle(color: Colors.green),
              )
            ],
          )),
    );
  }
}
