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
    return const Scaffold(
      body: Center(
        child: Text('hello!'),
      ),
    );
  }
}