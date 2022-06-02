import 'package:flutter/material.dart';
import 'package:flutterapp/global.dart';
import 'package:collection/collection.dart';
import 'package:flutterapp/control_db.dart';

class ServiceModel extends ChangeNotifier {
  final List<Service> _service = [];
  DbService db = DbService();

  ServiceModel() {
    debugPrint('create db var!');
  }
  UnmodifiableListView<Service> get items => UnmodifiableListView(_service);

  int get lengthService => _service.length;

  void add(Service service) {
    _service.add(service);
    notifyListeners();
  }

  void remove(Service service) {
    _service.remove(service);
    notifyListeners();
  }

  void removeAll() {
    _service.clear();
    notifyListeners();
  }

  int priceAll() {
    int result = 0;

    for (int idx = 0; idx < lengthService; idx++) {
      if (_service[idx].membershipCost != null) {
        result += _service[idx].membershipCost!.toInt();
      }
    }

    return result;
  }
}
