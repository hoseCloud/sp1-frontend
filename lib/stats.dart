import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class Item {
  int id;
  String name;
  Item(this.id, this.name);
}

class CartModel extends ChangeNotifier {
  /// 내부적으로 사용될 Cart의 목록
  final List<Item> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// 현재 아이템들의 모든 가격
  int get totalPrice => _items.length * 42;

  /// 아이템이 추가되면 리스너에게 아이템이 추가됨을 알린다.
  void add(Item item) {
    _items.add(item);
    // 해당 ChangeNorifiter를 감시하고있는 위젯들에게
    // 상태변화를 알리고 rebuild 하도록 한다.
    notifyListeners();
  }

  /// 아이템 목록을 클리어 하고 리스너에게 이를 알린다.
  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}