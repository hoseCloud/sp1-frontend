import 'package:flutter/material.dart';
import 'package:flutterapp/screen/login_service_006.dart';

// #002 ScreenAddAccount
class ScreenAddAccount extends StatefulWidget {
  const ScreenAddAccount({Key? key}) : super(key: key);

  @override
  State<ScreenAddAccount> createState() => _ScreenAddAccountState();
}

class _ScreenAddAccountState extends State<ScreenAddAccount> {
  String _value = '';
  final List<String> _service = ['netflix', 'wavve'];

  void _scanValue(String value) {
    setState(() {
      _value = value;
      debugPrint(_value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    List<Widget> containers = [
      Container(
        height: screenHeight * 0.3,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeight * 0.15,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Center(
                child: Text(
                  "추가할 서비스가 무엇인가요?",
                  textScaleFactor: 2.0,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: screenHeight * 0.15,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                obscureText: false,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
                onChanged: _scanValue,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: screenHeight * 0.55,
        alignment: Alignment.center,
        child: ListView(
          restorationId: 'test_view',
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            for (int index = 0; index < _service.length; index++)
              if (_service[index].contains(_value))
                Card(
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenLoginService(
                            serviceName: _service[index],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(
                        child: ListTile(
                          leading: const FlutterLogo(size: 100.0),
                          title: Text(
                            _service[index],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff2962ff),
        elevation: 0.0,
      ),
      body: ListView(
        children: containers,
      ),
    );
  }
}
