import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sp-1 frontend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'app bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.account_circle_sharp),
                ),
                Tab(
                  icon: Icon(Icons.payments_sharp),
                ),
                Tab(
                  icon: Icon(Icons.settings_sharp),
                ),
              ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's account here"),
            ),
            Center(
              child: Text("It's payments here"),
            ),
            Center(
              child: Text("It's settings here"),
            ),
          ],
        ),
      ),
    );
  }
}
