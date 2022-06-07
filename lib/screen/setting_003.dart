import 'package:flutter/material.dart';
import 'package:flutterapp/screen/register_member_005.dart';

// #003 ScreenSetting
class ScreenSetting extends StatelessWidget {
  const ScreenSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenRegisterMember()));
              },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.app_registration),
                    title: Text(
                      'Register to member',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
