import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  final String _imagePath = 'assets/mona-lisa.png';
  final String _username = 'monalisa';
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
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

                /// TODO: Launch a story
              },
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 0.90).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.elasticOut
                  )
                ),
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Color(0xff8a3ab9),
                        Color(0xffe95950),
                        Color(0xffbc2a8d),
                        Color(0xffcd486b),
                        Color(0xff4c68d7)
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.background),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
  void dispose(){
     _controller.dispose();
     super.dispose();
  }
}
