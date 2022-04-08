import 'package:flutter/material.dart';

// #002 ScreenAddAccount
class ScreenAddAccount extends StatelessWidget {
  const ScreenAddAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              color: Colors.blue,
            ),
          ),
          Center(
            child: Text(
              "추가할 서비스가 무엇인가요?",
              textScaleFactor: 3.0,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30.0),
          TextField(
            obscureText: false,
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
          ),
        ],
      ),
    );
  }
}