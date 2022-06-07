import 'package:flutter/material.dart';
import 'package:flutterapp/global.dart';
import 'package:collection/collection.dart';

class GroupModel extends ChangeNotifier {
  final List<Group> _group = [];

  UnmodifiableListView<Group> get items => UnmodifiableListView(_group);

  int get lengthGroup => _group.length;

  void add(Group group) {
    _group.add(group);
    notifyListeners();
  }

  void remove(Group group) {
    _group.remove(group);
    notifyListeners();
  }

  void removeAll() {
    _group.clear();
    notifyListeners();
  }

  int priceAll() {
    int result = 0;

    for (int idx = 0; idx < lengthGroup; idx++) {
      result += _group[idx].ott.membership.cost;
    }

    return result;
  }

  bool search(String name, String id) {
    bool result = _group.any(
      (x) {
        if (x.ott.name != name || x.ott.account.id != id) {
          return false;
        }
        return true;
      },
    );

    return result;
  }

  bool update(Service service) {
    bool result = false;
    if (search(service.name, service.account.id)) {
      for (int i = 0; i < _group.length; i++) {
        if (_group[i].ott.name == service.name &&
            _group[i].ott.account.id == service.account.id) {
          _group[i].ott = service;
          result = true;
          break;
        }
      }
    }

    notifyListeners();
    return result;
  }
}

class UserModel extends ChangeNotifier {
  final List<User> _user = [];

  UserModel() {
    debugPrint('create db var!');
  }
  UnmodifiableListView<User> get items => UnmodifiableListView(_user);

  int get lengthUser => _user.length;

  void add(User user) {
    _user.add(user);
    notifyListeners();
  }

  void remove(User user) {
    _user.remove(user);
    notifyListeners();
  }

  void removeAll() {
    _user.clear();
    notifyListeners();
  }

  bool search(String id) {
    bool result = _user.any(
      (x) {
        if (x.id != id) {
          return false;
        }
        return true;
      },
    );

    return result;
  }

  bool update(User user) {
    bool result = false;
    if (search(user.id)) {
      for (int i = 0; i < _user.length; i++) {
        if (_user[i].id == user.id) {
          _user[i] = user;
          result = true;
          break;
        }
      }
    }

    notifyListeners();
    return result;
  }
}
