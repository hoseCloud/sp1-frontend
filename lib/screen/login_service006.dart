import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// #006 ScreenLoginService
class ScreenLoginService extends StatefulWidget {
  const ScreenLoginService({Key? key}) : super(key: key);

  @override
  State<ScreenLoginService> createState() => _ScreenLoginServiceState();
}

class _ScreenLoginServiceState extends State<ScreenLoginService> {
  String _id = '';
  String _pw = '';

  void _scanId(String value) {
    setState(() {
      _id = value;
      debugPrint('id $_id');
    });
  }
  void _scanPw(String value) {
    setState(() {
      _pw = value;
      debugPrint('pw: $_pw');
    });
  }
  void _doLogin() async {
    debugPrint('Do login');

    final response = await http.post(
        Uri.parse('http://g3un.ddns.net:6644/netflix/info'),
        body: jsonEncode(<String, String> {
          'id': _id,
          'pw': _pw,
        })
    );
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    //debugPrint(await http.read(Uri.parse('https://httpbin.org/post')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.1,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.red,
                  child: const BackButton(
                    color: Colors.blue,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.15,
                  alignment: Alignment.center,
                  color: Colors.orange,
                  child: const Text(
                    "로그인",
                    textScaleFactor: 2.5,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    height: constraints.maxHeight * 0.2,
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.1,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.blue,
                          child: TextField(
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '아이디',
                            ),
                            onChanged: _scanId,
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.1,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.red,
                          child: TextField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '비밀번호',
                            ),
                            onChanged: _scanPw,
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  height: constraints.maxHeight * 0.1,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.green,
                  child: ElevatedButton(
                    onPressed: () {
                      _doLogin();
                    },
                    child: const Text('로그인'),
                  )
                ),
                Container(
                  height: constraints.maxHeight * 0.45,
                  alignment: Alignment.center,
                  color: Colors.blue,
                ),
              ],
            );
          }
      ),
    );
  }
}