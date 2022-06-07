import 'package:flutter/material.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/uris.dart';

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
    });
  }

  void _scanId(String value) {
    setState(() {
      _id = value;
    });
  }

  void _scanPw(String value) {
    setState(() {
      _pw = value;
    });
  }

  void _scanPwc(String value) {
    setState(() {
      _pwc = value;
    });
  }

  void _doRegister() {
    if (_pw != _pwc) {
      return;
    }

    debugPrint('Do register');

    User user = User(_id, _pw, _email, []);
    Users().userAdd(user);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> containers = [
      Container(
        height: screenHeight * 0.15,
        alignment: Alignment.center,
        child: const Text(
          "로그인",
          textScaleFactor: 2.5,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          height: screenHeight * 0.4,
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.1,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이메일',
                  ),
                  onChanged: _scanEmail,
                ),
              ),
              Container(
                height: screenHeight * 0.1,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
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
                height: screenHeight * 0.1,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
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
                height: screenHeight * 0.1,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
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
          )),
      Container(
        height: screenHeight * 0.1,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            _doRegister();
          },
          child: const Text('회원가입'),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff2962ff),
        elevation: 0.0,
      ),
      body: ListView(
        children: containers,
      ),
    );
  }
}
