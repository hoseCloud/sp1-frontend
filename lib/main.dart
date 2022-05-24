import 'package:flutter/material.dart';
import 'package:flutterapp/screen/splash009.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ServiceModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sp-1 frontend',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        colorSchemeSeed: const Color(0xff2962ff),
        useMaterial3: true,
      ),
      home: const ScreenSplash(),
    );
  }
}