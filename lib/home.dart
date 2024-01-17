import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _imagePath = 'assets/mona-lisa.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            Container(
              width: 150.0,
              height: 150.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xff8a3ab9), 
                    Color(0xffe95950), 
                    Color(0xffbc2a8d), 
                    Color(0xffcd486b), 
                    Color(0xff4c68d7)
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.background
                  ),
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
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'monalisa',
                style: TextStyle(
                  fontSize: 25.0
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
