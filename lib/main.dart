import 'package:flutter/material.dart';
import 'package:stories_demo/home.dart';
import 'package:stories_demo/view_story.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stories Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/view_story':(context) => const ViewStory()
      },
    );
  }
}
