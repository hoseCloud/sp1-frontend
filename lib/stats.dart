import 'package:flutter/material.dart';
import 'package:flutterapp/global.dart';
import 'package:collection/collection.dart';
import 'package:flutterapp/controlDb.dart';

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
}