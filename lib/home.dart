import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final String _imagePath = 'assets/mona-lisa.png';
  final String _username = 'monalisa';
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            GestureDetector(
              onTap: () {
                _controller.forward().then((_) {
                  _controller.reverse();

                  Navigator.pushNamed(context, '/view_story');
                });
              },
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 0.90).animate(CurvedAnimation(
                    parent: _controller, curve: Curves.elasticOut)),
                child: SizedBox(
                  width: 150.0,
                  height: 150.0,
                  child: CustomPaint(
                    painter: RingPainter(
                      segmentCount: 3,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(
                        foregroundImage: AssetImage(
                          _imagePath,
                        ),
                        radius: 75.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                _username,
                style: const TextStyle(fontSize: 25.0),
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RingPainter extends CustomPainter {
  final double strokeWidth = 5.0;
  final double gapSize = 25.0;
  final Gradient gradient = const LinearGradient(
    colors: [
      Color(0xff8a3ab9),
      Color(0xffe95950),
      Color(0xffbc2a8d),
      Color(0xffcd486b),
      Color(0xff4c68d7)
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft
  );

  final int segmentCount;

  RingPainter({
    this.segmentCount = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final gapAngle = gapSize / radius;

    for (int i = 0; i < segmentCount; i++) {
      final startAngle = i * 2 * pi / segmentCount;
      final endAngle = startAngle + 2 * pi / segmentCount - gapAngle;
      canvas.drawArc(
        Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(RingPainter oldDelegate) => false;
}