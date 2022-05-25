import 'package:flutter/material.dart';
import 'package:flutterapp/screen/account001.dart';
import 'package:flutterapp/screen/setting003.dart';
import 'package:flutterapp/screen/payments007.dart';

class ScreenMainTabs extends StatefulWidget {
  const ScreenMainTabs({Key? key}) : super(key: key);

  @override
  State<ScreenMainTabs> createState() => _ScreenMainTabsState();
}

class _ScreenMainTabsState extends State<ScreenMainTabs> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ScreenPayments(),
    ScreenAccount(),
    ScreenSetting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void refresh() {
    debugPrint('refresh tapped!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<Text>(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text(
                      'Refresh all account',
                    ),
                    onTap: refresh,
                  ),
                  const PopupMenuItem(
                    child: Text(
                      '2',
                    ),
                  ),
                  const PopupMenuItem(
                    child: Text(
                      '3',
                    ),
                  ),
                ];
              }
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text('Hose'),
              accountEmail: Text('hose@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: FlutterLogo(size: 42.0),
              ),
            ),
            ListTile(
              title: Text('Detail'),
              leading: Icon(Icons.person),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_sharp),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_sharp),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}