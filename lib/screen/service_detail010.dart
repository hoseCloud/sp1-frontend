import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';

// #010 ScreenServiceDetail
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
            'paymentDetail: ${data.paymentDetail}\n'
            'paymentNext: ${data.paymentNext}\n'
            'membershipType: ${data.membershipType}\n'
            'membershipCost: ${data.membershipCost}\n'
            'status: ${data.status}\n',
            textScaleFactor: 2.0,
          ),
          ElevatedButton(
              onPressed: () {
                debugPrint('Refresh tapped!');
              },
              child: const Center(
                child: Text(
                  'Refresh',
                  textScaleFactor: 2.0,
                ),
              )),
          ElevatedButton(
              onPressed: () {
                dynamic pro = Provider.of<ServiceModel>(context, listen: false);
                pro.remove(data);
                pro.db.dbDelete(data);
                Navigator.pop(context);
                debugPrint('Delete tapped!');
              },
              child: const Center(
                child: Text(
                  'Delete',
                  textScaleFactor: 2.0,
                ),
              )),
        ],
      ),
    );
  }
}
