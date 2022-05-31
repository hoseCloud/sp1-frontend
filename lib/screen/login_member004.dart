import 'package:flutter/material.dart';

// #004 ScreenLoginMember
class ScreenLoginMember extends StatefulWidget {
  const ScreenLoginMember({Key? key}) : super(key: key);

  @override
  State<ScreenLoginMember> createState() => _ScreenLoginMemberState();
}

class _ScreenLoginMemberState extends State<ScreenLoginMember> {
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
  void _doLogin() {
    debugPrint('Do login');
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> containers = [
      Container(
        height: screenHeight * 0.15,
        alignment: Alignment.center,
        color: Colors.orange,
        child: const Text(
          "로그인",
          textScaleFactor: 2.5,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          height: screenHeight * 0.2,
          alignment: Alignment.center,
          color: Colors.yellow,
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.1,
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
                height: screenHeight * 0.1,
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
        height: screenHeight * 0.1,
        alignment: Alignment.center,
        color: Colors.green,
        child: Row(
          children: <Widget> [
            Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.5,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16.0),
              color: Colors.yellow,
              child: const Text('회원가입'),
            ),
            Container(
                height: screenHeight * 0.1,
                width: screenWidth * 0.5,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(16.0),
                color: Colors.orange,
                child: ElevatedButton(
                  onPressed: () {
                    _doLogin();
                  },
                  child: const Text('로그인'),
                )
            ),
          ],
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