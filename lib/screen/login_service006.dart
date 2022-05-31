import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';

// #006 ScreenLoginService
class ScreenLoginService extends StatefulWidget {
  const ScreenLoginService({Key? key, required this.serviceName}) : super(key: key);
  final String serviceName;

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
    String name = widget.serviceName;
    dynamic pro = Provider.of<ServiceModel>(context, listen: false);
    Service service = Service.account(name, _id, _pw);
    service.changeStatus(0);
    await pro.add(service);
    final response = await http.post(
      Uri.parse('https://sp1-backend.ddns.net/$name/account'),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode(<String, String> {
        'ott_id': _id,
        'ott_pw': _pw,
      }),
    );
    if(response.statusCode == 200) {
      debugPrint("success 200");
      pro.remove(service);
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> user = jsonDecode(response.body);
      Map<String, dynamic> payment = user['payment'];
      Map<String, dynamic> membership = user['membership'];
      service = Service(
          name, user['id'], user['pw'],
          payment['type'], payment['detail'], payment['next'],
          membership['type'], membership['cost']);
      service.changeStatus(response.statusCode);
      await pro.add(service);
      await pro.db.dbInsert(service);
    }
    else {
      debugPrint("fail... else");
      pro.remove(service);
      service.changeStatus(response.statusCode);
      pro.add(service);
    }
    debugPrint('Url: https://sp1-backend.ddns.net/$name/account');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
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
          )
      ),
      Container(
          height: screenHeight * 0.1,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              _doLogin();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('로그인'),
          )
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