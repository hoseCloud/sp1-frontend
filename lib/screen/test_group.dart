import 'package:flutter/material.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/uris.dart';

class TestGroup extends StatefulWidget {
  const TestGroup({Key? key}) : super(key: key);

  @override
  State<TestGroup> createState() => _TestGroupState();
}

class _TestGroupState extends State<TestGroup> {
  void search() async {
    debugPrint('search tap!');
    Group group = await Groups().groupSearch('629e1576fe4214a8bbd75e20');

    debugPrint(group.toString());
  }

  void make() async {
    debugPrint('make tap!');
    String groupId = await Groups()
        .groupMake('hose', 'netflix', '4osecloud@gmail.com', 'JjJ2hyeyxDEWXGx');
    debugPrint(groupId);
  }

  void delete() async {
    debugPrint('delete tap!');
    await Groups().groupDelete('groupId', '4osecloud@gmail.com');
  }

  void update() async {
    debugPrint('update tap!');
    await Groups().groupUpdate('groupId', Service.init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                search();
              },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.login),
                    title: Text(
                      'Search group',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                make();
              },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.login),
                    title: Text(
                      'Make group',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                delete();
              },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.login),
                    title: Text(
                      'Delete group',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                update();
              },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.login),
                    title: Text(
                      'Update group',
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
