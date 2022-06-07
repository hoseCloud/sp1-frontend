import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/uris.dart';

// #006 ScreenLoginService
class ScreenLoginService extends StatefulWidget {
  const ScreenLoginService({Key? key, required this.serviceName})
      : super(key: key);
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
    });
  }

  void _scanPw(String value) {
    setState(() {
      _pw = value;
    });
  }

  void _doLogin() async {
    debugPrint('Do login');

    GroupModel proGroup = Provider.of<GroupModel>(context, listen: false);
    UserModel proUser = Provider.of<UserModel>(context, listen: false);
    String name = widget.serviceName;
    Service service = Service.account(name, Account(_id, _pw));
    Group group = Group.init();

    service.changeStatus(0);
    group.ott = service;
    proGroup.add(group);

    service = await OTT().doAccountLogin(service);
    group.ott = service;
    proGroup.update(group);

    if (service.status == 200) {
      String appId = proUser.items[0].id;
      String groupId = await Groups().groupMake(appId, name, _id, _pw);

      group.groupId = groupId;
      proGroup.update(group);

      await Groups().groupUpdate(groupId, service);
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
        child: Row(
          children: <Widget> [
            SizedBox(
              width: screenWidth * 0.14,
            ),
            Image.asset('assets/images/${widget.serviceName}.png'),
            const Text(
              "로그인",
              textScaleFactor: 2.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
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
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              _doLogin();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('로그인'),
          )),
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
