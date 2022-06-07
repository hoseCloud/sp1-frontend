import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Account {
  String id = '';
  String pw = '';

  Account.init() {
    id = '';
    pw = '';
  }
  Account(this.id, this.pw);
}

class Payment {
  String type = '';
  String detail = '';
  int next = 0;

  Payment.init() {
    type = '';
    detail = '';
    next = 0;
  }
  Payment(this.type, this.detail, this.next);
}

class Membership {
  int type = 0;
  int cost = 0;

  Membership.init() {
    type = 0;
    cost = 0;
  }
  Membership(this.type, this.cost);
}

class Member {
  String appId = '';
  int isAdmin = 0;

  Member.init() {
    appId = '';
    isAdmin = 0;
  }
  Member(this.appId, this.isAdmin);
}

class User {
  String id = '';
  String pw = '';
  String email = '';
  List<Group> groups = [];

  User.init() {
    id = '';
    pw = '';
    email = '';
    groups = [];
  }
  User(this.id, this.pw, this.email, this.groups);
}

class Group {
  String groupId = '';
  Service ott = Service.init();
  int updateTime = 0;
  List<Member> members = [];

  Group.init() {
    groupId = '';
    ott = Service.init();
    updateTime = 0;
    members = [];
  }
  Group(this.groupId, this.ott, this.updateTime, this.members);
}

class Service {
  String name = '';
  Account account = Account.init();
  Payment payment = Payment.init();
  Membership membership = Membership.init();
  int status = 0;

  Service.init() {
    name = '';
    account = Account.init();
    payment = Payment.init();
    membership = Membership.init();
    status = 0;
  }
  Service(this.name, this.account, this.payment, this.membership);
  Service.account(this.name, this.account);

  void changeStatus(int status) {
    this.status = status;
  }
}

abstract class Db {
  late final String dbName;
  bool opening = false;
  late String databasePath;
  late Database db;

  void error(String msg) {
    debugPrint('Error! ' + msg);
  }

  Future<void> dbOpen() async {
    if (!opening) {
      databasePath = await getDatabasesPath();
      String path = join(databasePath, dbName + '.db');
      db = await openDatabase(path, version: 1);
      opening = true;
      debugPrint('Success to open db!');
    }
  }

  Future<void> dbClose() async {
    if (opening) {
      db.close();
      opening = false;
      debugPrint('Success to close db!');
    }
  }

  Future<void> dbEliminate() async {
    if (opening) {
      await deleteDatabase(join(databasePath, dbName + '.db'));
      debugPrint('Success to eliminate db!');
    } else {
      error('Db isn\'t opened!');
    }
  }

  Future<void> dbCreate();
  Future<void> dbInsert(dynamic data);
  Future<void> dbDelete(dynamic data);
  Future<void> dbUpdate();
  Future<dynamic> dbSelect();
}
