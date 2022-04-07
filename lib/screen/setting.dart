/* List of contained screens
 #003 ScreenSetting
*/
import 'package:flutter/material.dart';

// #003 ScreenSetting
class ScreenSetting extends StatelessWidget {
  const ScreenSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(15.0),
          children: const <Widget>[
            Text("test"),
            Text("test"),
            Text("test"),
            Text("test"),
          ],
      ),
    );
  }
}