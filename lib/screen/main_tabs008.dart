import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/screen/account001.dart';
import 'package:flutterapp/screen/setting003.dart';
import 'package:flutterapp/screen/payments007.dart';
import 'package:flutterapp/screen/splash009.dart';

// #008 ScreenMainTabs
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

  void logout() async {
    // 4. 로그아웃시 stats에 저장된 정보를 삭제
    UserModel proUser = Provider.of<UserModel>(context, listen: false);
    proUser.removeAll();

    GroupModel proGroup = Provider.of<GroupModel>(context, listen: false);
    proGroup.removeAll();
  }

  @override
  Widget build(BuildContext context) {
    UserModel proUser = Provider.of<UserModel>(context, listen: false);
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
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(proUser.items[0].id),
              accountEmail: Text(proUser.items[0].email),
              currentAccountPicture: const CircleAvatar(
                child: FlutterLogo(size: 42.0),
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {
                debugPrint('Logout!');
                logout();

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenSplash(),
                    ));
              },
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