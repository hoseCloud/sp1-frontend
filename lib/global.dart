import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class User {
  String id;
  String pw;
  String email;
  int auto = 0;

  User(this.id, this.pw, this.email, this.auto);
}

class Service {
  String name;
  String accountId;
  String accountPw;
  String? paymentType;
  String? paymentDetail;
  int? paymentNext;
  int? membershipType;
  int? membershipCost;
  int status = 0;

  Service(
      this.name,
      this.accountId,
      this.accountPw,
      this.paymentType,
      this.paymentDetail,
      this.paymentNext,
      this.membershipType,
      this.membershipCost);
  Service.account(this.name, this.accountId, this.accountPw);
  Service.payment(this.name, this.accountId, this.accountPw, this.paymentType,
      this.paymentDetail, this.paymentNext);
  Service.membership(this.name, this.accountId, this.accountPw,
      this.membershipType, this.membershipCost);

  void getPayment(
      String? paymentType, String? paymentDetail, int? paymentNext) {
    this.paymentType = paymentType;
    this.paymentDetail = paymentDetail;
    this.paymentNext = paymentNext;
  }

  void getMembership(int? membershipType, int? membershipCost) {
    this.membershipType = membershipType;
    this.membershipCost = membershipCost;
  }

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
