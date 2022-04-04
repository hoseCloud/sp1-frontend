import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sp-1 frontend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'app bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    ScreenAccount(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

  return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.blueAccent),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_sharp),
            label: 'Payments',
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

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
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
    );
  }
}