import 'package:flutter/material.dart';
import 'package:flutterapp/screen/add_account002.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/screen/service_detail010.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// #001 ScreenAccount
class ScreenAccount extends StatefulWidget {
  const ScreenAccount({Key? key}) : super(key: key);

  @override
  State<ScreenAccount> createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount> {

  Color sColor(int status) {
    Color result = Colors.deepOrange;

    if (status == 0) {
      result = Colors.white30;
    }
    if (status == 200) {
      result = Colors.greenAccent;
    }
    if (status == 400 || status == 401) {
      result = Colors.redAccent;
    }
    if (status == 405 || status == 500) {
      result = Colors.grey;
    }
    return result;
  }
  dynamic sIcons (int status) {
    dynamic result = const Icon(Icons.question_mark);

    if (status == 0) {
      result = LoadingAnimationWidget.threeArchedCircle(color: Colors.black, size: 20.0);
    }
    if (status == 200) {
      result = const Icon(Icons.check);
    }
    if (status == 400 || status == 401) {
      result = const Icon(Icons.block);
    }
    if (status == 405 || status == 500) {
      result = const Icon(Icons.build);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    dynamic pro = Provider.of<ServiceModel>(context, listen: true);
    return Scaffold(
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.blueAccent),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScreenAddAccount()),
            );
          },
          label: const Text('Add account'),
          icon: const Icon(Icons.add),
        ),
      ),
      body: Scrollbar(
        child: ListView(
          restorationId: 'test_view',
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            for(int index = 0; index < pro.lengthService; index++)
              Card(
                color: sColor(pro.items[index].status),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          ScreenServiceDetail(data: pro.items[index])),
                    );
                  },
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(
                      child: ListTile(
                        trailing: sIcons(pro.items[index].status),
                        title: Text(
                          pro.items[index].name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 2.0,
                        ),
                        subtitle: Text(
                          pro.items[index].accountId,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}