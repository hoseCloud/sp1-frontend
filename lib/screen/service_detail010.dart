import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/uris.dart';

// #010 ScreenServiceDetail
class ScreenServiceDetail extends StatelessWidget {
  const ScreenServiceDetail({Key? key, required this.data}) : super(key: key);
  final Service data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'name: ${data.name}\n'
            'accountId: ${data.account.id}\n'
            'accountPw: ${data.account.pw}\n'
            'paymentType: ${data.payment.type}\n'
            'paymentDetail: ${data.payment.detail}\n'
            'paymentNext: ${data.payment.next}\n'
            'membershipType: ${data.membership.type}\n'
            'membershipCost: ${data.membership.cost}\n'
            'status: ${data.status}\n',
            textScaleFactor: 2.0,
          ),
          ElevatedButton(
              onPressed: () async {
                ServiceModel pro =
                    Provider.of<ServiceModel>(context, listen: false);
                Service service = await Netflix().accountRefresh(data);
                pro.update(service);
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
                ServiceModel pro =
                    Provider.of<ServiceModel>(context, listen: false);
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
