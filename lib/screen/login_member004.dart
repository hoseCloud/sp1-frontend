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
    });
  }
  void _scanPw(String value) {
    setState(() {
      _pw = value;
    });
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
                color: Colors.red,
                child: const BackButton(
                  color: Colors.blue,
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.15,
                alignment: Alignment.center,
                color: Colors.orange,
              ),
              Container(
                height: constraints.maxHeight * 0.3,
                alignment: Alignment.center,
                color: Colors.yellow,
              ),
              Container(
                height: constraints.maxHeight * 0.1,
                alignment: Alignment.center,
                color: Colors.green,
              ),
              Container(
                height: constraints.maxHeight * 0.35,
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