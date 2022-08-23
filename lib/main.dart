import 'package:flutter/material.dart';
import 'package:clock_app/screen/change_place.dart';
import 'package:clock_app/screen/loading.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/day.jpg"), context); // cache image
    precacheImage(const AssetImage("assets/night.jpg"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes debug banner
      routes: {
        '/': (context) => const Loading(),
        '/home': (context) => const MyHomePage(
              title: 'World Clock',
            ),
        '/location': (context) => const Location(),
      },
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: const ColorScheme.dark(),
      ),
    );
  }
}
