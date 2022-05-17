import 'package:flutter/material.dart';
import 'package:flutterapp/screen/add_account002.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';

// #001 ScreenAccount
class ScreenAccount extends StatefulWidget {
  const ScreenAccount({Key? key}) : super(key: key);

  @override
  State<ScreenAccount> createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount> {

  void selectValue(String value, int index) {
    if(value == 'Remove') {
      super.setState(() {
        //service.removeAt(index);
      });
      debugPrint('Remove!');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    debugPrint('One time code????');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
        builder: (context, service, child) => Scaffold(
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
                if(child != null) child,
                for(int index = 0; index < service.lengthService; index++)
                  Card(
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                      },
                      child: SizedBox(
                        width: 300,
                        height: 100,
                        child: Center(
                          child: ListTile(
                            title: Text(
                                service.items[index].name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor: 2.0,
                            ),
                            subtitle: Text(
                                service.items[index].accountId,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor: 1.5,
                            ),
                            trailing: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              onSelected: (value) => {
                                debugPrint('$value tapped.'),
                                selectValue(value, index)
                              },
                              itemBuilder: (context) => <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: "Hello",
                                  child: ListTile(
                                    leading: Icon(Icons.front_hand),
                                    title: Text("Hello"),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: "Remove",
                                  child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text("Remove"),
                                  ),
                                ),
                              ],
                            ),
                          ),
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