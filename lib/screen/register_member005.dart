import 'package:flutter/material.dart';

// #005 ScreenRegisterMember
class ScreenRegisterMember extends StatefulWidget {
  const ScreenRegisterMember({Key? key}) : super(key: key);

  @override
  State<ScreenRegisterMember> createState() => _ScreenRegisterMemberState();
}

class _ScreenRegisterMemberState extends State<ScreenRegisterMember> {
  String _email = '';
  String _id = '';
  String _pw = '';
  String _pwc = '';

  void _scanEmail(String value) {
    setState(() {
      _email = value;
      debugPrint('email $_email');
    });
  }
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
  void _scanPwc(String value) {
    setState(() {
      _pwc = value;
      debugPrint('pwc: $_pwc');
    });
  }
  void _doRegister() {
    debugPrint('Do register');
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
                    height: constraints.maxHeight * 0.4,
                    alignment: Alignment.center,
                    color: Colors.yellow,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.1,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.red,
                          child: TextField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '이메일',
                            ),
                            onChanged: _scanEmail,
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.1,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.orange,
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
                          color: Colors.yellow,
                          child: TextField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '비밀번호',
                            ),
                            onChanged: _scanPw,
                          ),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.1,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.green,
                          child: TextField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '비밀번호 확인',
                            ),
                            onChanged: _scanPwc,
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  height: constraints.maxHeight * 0.1,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.purple,
                  child: ElevatedButton(
                    onPressed: () {
                      _doRegister();
                    },
                    child: const Text('회원가입'),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.25,
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