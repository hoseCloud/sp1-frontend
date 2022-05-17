import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';

class StatsTest extends StatefulWidget {
  const StatsTest({Key? key}) : super(key: key);

  @override
  State<StatsTest> createState() => _StatsTestState();
}

class _StatsTestState extends State<StatsTest> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel> (
      builder: (context, cart, child) => Stack(
        children: [
          if(child != null) child,
          Center(child: Text("Total price: ${cart.totalPrice}")),
          Card(
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                cart.add(Item(1, '12'));
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