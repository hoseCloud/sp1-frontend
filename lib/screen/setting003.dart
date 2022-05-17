import 'package:flutter/material.dart';
import 'package:flutterapp/screen/login_member004.dart';
import 'package:flutterapp/screen/register_member005.dart';
import 'package:flutterapp/screen/login_service006.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/screen/test_stats.dart';

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
                      MaterialPageRoute(builder: (context) => const ScreenLoginMember())
                  );
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.login),
                      title: Text(
                        'Login to member',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScreenRegisterMember())
                  );
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
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScreenLoginService(serviceName: 'netflix'))
                  );
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.login),
                      title: Text(
                        'Login to Netflix',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loading())
                  );
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.login),
                      title: Text(
                        'Loading screen',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StatsTest())
                  );
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.login),
                      title: Text(
                        'Test stats',
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