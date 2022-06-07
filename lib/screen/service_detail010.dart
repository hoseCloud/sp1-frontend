import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/uris.dart';

// #010 ScreenServiceDetail
class ScreenServiceDetail extends StatelessWidget {
  const ScreenServiceDetail({Key? key, required this.data}) : super(key: key);
  final Group data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text('''
            groupId: ${data.groupId}
            name: ${data.ott.name}
            accountId: ${data.ott.account.id}
            accountPw: ${data.ott.account.pw}
            paymentType: ${data.ott.payment.type}
            paymentDetail: ${data.ott.payment.detail}
            paymentNext: ${data.ott.payment.next}
            membershipType: ${data.ott.membership.type}
            membershipCost: ${data.ott.membership.cost}
            status: ${data.ott.status}
            ''',
            textScaleFactor: 2.0,
            textAlign: TextAlign.left,
          ),
          ElevatedButton(
              onPressed: () async {
                GroupModel pro =
                    Provider.of<GroupModel>(context, listen: false);
                /*
                Service service = await Netflix().accountRefresh(data.ott);
                pro.update(service);
                */
                Navigator.pop(context);
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
                GroupModel pro =
                    Provider.of<GroupModel>(context, listen: false);
                pro.remove(data);
                // pro.db.dbDelete(data);
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
