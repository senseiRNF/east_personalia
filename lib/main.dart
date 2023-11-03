import 'package:east_personalia/view_pages/splash_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(const EastPersonaliaApp()));
}

class EastPersonaliaApp extends StatelessWidget {
  const EastPersonaliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'East Personalia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: 'Lato',
      ),
      routes: {
        '/': (context) => const SplashViewPage(),
      },
    );
  }
}