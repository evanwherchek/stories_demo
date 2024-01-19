import 'package:flutter/material.dart';
import 'dart:math';

import 'package:stories_demo/story_arguments.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final String _imagePath = 'assets/mona-lisa.png';
  final String _username = 'monalisa';
  late AnimationController _controller;
  late StoryArguments _storyArguments;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _storyArguments = StoryArguments(unreadItems: 5, readItems: 0);
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
                });

                Navigator.pushNamed(context, '/view_story',
                        arguments: _storyArguments)
                    .then((value) {
                  setState(() {
                    _storyArguments = value as StoryArguments;
                  });
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
                        unreadItems: _storyArguments.unreadItems,
                        readItems: _storyArguments.readItems),
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

  final Gradient gradientUnread = const LinearGradient(colors: [
    Color(0xff8a3ab9),
    Color(0xffe95950),
    Color(0xffbc2a8d),
    Color(0xffcd486b),
    Color(0xff4c68d7)
  ], begin: Alignment.topRight, end: Alignment.bottomLeft);

  final Gradient gradientRead = const LinearGradient(colors: [
    Color(0x282A3AB9),
    Color(0x28E95A50),
    Color(0x28BC2A8E),
    Color(0x28CD486B),
    Color(0x284C68D7)
  ], begin: Alignment.topRight, end: Alignment.bottomLeft);

  final int readItems;
  final int unreadItems;

  RingPainter({
    this.unreadItems = 1,
    this.readItems = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    final paint = Paint()
      ..shader = gradientUnread.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final gapAngle = gapSize / radius;

    int totalSegments = unreadItems + readItems;

    for (int i = 0; i < totalSegments; i++) {
      final startAngle = i * 2 * pi / totalSegments;
      final endAngle = startAngle + 2 * pi / totalSegments - gapAngle;

      if (i >= unreadItems) {
        paint.shader = gradientRead.createShader(rect);
      }

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
