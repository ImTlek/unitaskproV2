import 'package:flutter/material.dart';

class CustomShape extends StatelessWidget {
  final double bottomRadius;
  final double topLeftRadius;
  final double topRightRadius;
  final Color color;

  const CustomShape({
    super.key,
    required this.bottomRadius,
    required this.topLeftRadius,
    required this.topRightRadius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShapePainter(
        bottomRadius: bottomRadius,
        topLeftRadius: topLeftRadius,
        topRightRadius: topRightRadius,
        color: color,
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double bottomRadius;
  final double topLeftRadius;
  final double topRightRadius;
  final Color color;

  ShapePainter({
    required this.bottomRadius,
    required this.topLeftRadius,
    required this.topRightRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height - bottomRadius, size.width, size.height)
      ..lineTo(size.width, 0)
      ..arcToPoint(Offset(topRightRadius, 0),
          radius: Radius.circular(topRightRadius))
      ..arcToPoint(Offset(0, topLeftRadius),
          radius: Radius.circular(topLeftRadius))
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
