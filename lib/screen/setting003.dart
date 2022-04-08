import 'package:flutter/material.dart';

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
                  debugPrint('Card tapped.');
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.login),
                      title: Text(
                        'Login to app',
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