import 'package:flutter/material.dart';
import 'package:flutterapp/stats.dart';
import 'package:provider/provider.dart';

// #007 ScreenPayments
class ScreenPayments extends StatefulWidget {
  const ScreenPayments({Key? key}) : super(key: key);

  @override
  State<ScreenPayments> createState() => _ScreenPaymentsState();
}

class _ScreenPaymentsState extends State<ScreenPayments> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupModel>(
      builder: (context, service, child) => Scaffold(
        body: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  child: Center(
                    child: Text(
                      '이번달 결제금액\n${service.priceAll()}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 2.0,
                    ),
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
