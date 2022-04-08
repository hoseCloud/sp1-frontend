import 'package:flutter/material.dart';
import '/screen/add_account002.dart';

// #001 ScreenAccount
class ScreenAccount extends StatelessWidget {
  const ScreenAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            for(int index = 0; index < 5; index++)
              Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: const SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(
                      child: ListTile(
                        leading: FlutterLogo(size: 100.0),
                        title: Text(
                          'OTT service\'s name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 2.0,
                        ),
                        subtitle: Text(
                          'account: ***',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.5,
                        ),
                        trailing: Icon(Icons.more_vert),
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