import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';

// #001 ScreenAccount
class ScreenServiceDetail extends StatelessWidget {
  const ScreenServiceDetail({Key? key, required this.data}) : super(key: key);
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'name: ${data.name}\n'
                'accountId: ${data.accountId}\n'
                'accountPw: ${data.accountPw}\n'
                'paymentType: ${data.paymentType}\n'
                'paymentDatail: ${data.paymentDetail}\n'
                'paymentNext: ${data.paymentNext}\n'
                'membershipType: ${data.membershipType}\n'
                'membershipCost: ${data.membershipCost}\n'
                'status: ${data.status}\n',
            textScaleFactor: 2.0,
          ),
          ElevatedButton(
            onPressed: () {
              debugPrint('refresh tapped!');
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}