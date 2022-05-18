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
  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Service> get items => UnmodifiableListView(_service);

  /// 현재 아이템들의 모든 가격
  /// int get totalPrice => _account.length * 42;
  int get lengthService => _service.length;

  /// 아이템이 추가되면 리스너에게 아이템이 추가됨을 알린다.
  void add(Service service) {
    _service.add(service);
    // 해당 ChangeNorifiter를 감시하고있는 위젯들에게
    // 상태변화를 알리고 rebuild 하도록 한다.
    notifyListeners();
  }

  /// 아이템 목록을 클리어 하고 리스너에게 이를 알린다.
  void removeAll() {
    _service.clear();
    notifyListeners();
  }
}