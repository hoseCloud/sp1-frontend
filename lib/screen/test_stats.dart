import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/stats.dart';

class StatsTest extends StatelessWidget {
  const StatsTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel> (
      builder: (context, service, child) => Column(
        children: [
          if(child != null) child,
          for(int index = 0; index < service.lengthService; index++)
            Text(service.items[index].accountId),
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                service.add(Service.account('netflix', 'hose', 'password'));
              },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.login),
                    title: Text(
                      'stats up',
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