import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';

// #007 ScreenPayments
class ScreenPayments extends StatefulWidget {
  const ScreenPayments({Key? key}) : super(key: key);

  @override
  State<ScreenPayments> createState() => _ScreenPaymentsState();
}

class _ScreenPaymentsState extends State<ScreenPayments> {
  @override
  Widget build(BuildContext context) {
    Service service = Provider.of<GroupModel>(context, listen: false).soonPayment();
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(service.payment.next * 1000);

    return Consumer<GroupModel>(
      builder: (context, group, child) => Scaffold(
        body: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  child: Center(
                    child: Text(
                      '이번달 결제금액\n${group.priceAll()} 원',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        '다가오는 결제일\n${dateTime.year}.${dateTime.month}.${dateTime.day}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        textScaleFactor: 2.0,
                      ),
                      ListTile(
                        leading: Image.asset('assets/images/${service.name}.png'),
                        title: Text(
                          '${service.membership.cost} 원',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 2.0,
                        ),
                        subtitle: Text(
                          service.account.id,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
