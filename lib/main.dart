import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/screen/splash_009.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GroupModel()),
        ChangeNotifierProvider(create: ((context) => UserModel())),
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
        colorSchemeSeed: const Color(0xff2962ff),
        backgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const ScreenSplash(),
    );
  }
}
