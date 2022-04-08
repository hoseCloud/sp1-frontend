import 'package:flutter/material.dart';

// #002 ScreenAddAccount
class ScreenAddAccount extends StatefulWidget {
  const ScreenAddAccount({Key? key}) : super(key: key);

  @override
  State<ScreenAddAccount> createState() => _ScreenAddAccountState();
}

class _ScreenAddAccountState extends State<ScreenAddAccount> {
  String _value = '';

  void _scanValue(String value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const Align(
            alignment: Alignment.topLeft,
            child: BackButton(
              color: Colors.blue,
            ),
          ),
          const Center(
            child: Text(
              "추가할 서비스가 무엇인가요?",
              textScaleFactor: 3.0,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30.0),
          TextField(
            obscureText: false,
            decoration: const InputDecoration(
              icon: Icon(Icons.search),
              border: OutlineInputBorder(),
              labelText: 'Search',
            ),
            onChanged: _scanValue,
          ),
          const SizedBox(height: 30.0),
          Text(_value),
        ],
      ),
    );
  }
}