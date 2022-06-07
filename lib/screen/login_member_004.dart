import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/uris.dart';
import 'package:flutterapp/screen/register_member_005.dart';
import 'package:flutterapp/screen/splash_009.dart';

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
    });
  }

  void _scanPw(String value) {
    setState(() {
      _pw = value;
    });
  }

  void _doLogin() async {
    debugPrint('Do login');

    User user = await Users().userLogin(_id, _pw);
    if (user.id != '') {
      UserModel pro = Provider.of<UserModel>(context, listen: false);
      pro.add(user);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenSplash(),
          ));
    } else {
      debugPrint('login fail...');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
          height: screenHeight * 0.2,
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
            ],
          )),
      Container(
        height: screenHeight * 0.1,
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Container(
              height: screenHeight * 0.1,
              width: screenWidth * 0.5,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenRegisterMember(),
                      ));
                  },
                  child: const Text('회원가입'),
                ),
            ),
            Container(
                height: screenHeight * 0.1,
                width: screenWidth * 0.5,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _doLogin();
                  },
                  child: const Text('로그인'),
                )),
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
