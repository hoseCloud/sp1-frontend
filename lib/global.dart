import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Service {
  String name;
  String accountId;
  String accountPw;
  String? paymentType;
  String? paymentDetail;
  String? paymentNext;
  int? membershipType;
  int? membershipCost;

  Service(
      this.name, this.accountId, this.accountPw,
      this.paymentType, this.paymentDetail, this.paymentNext,
      this.membershipType, this.membershipCost);
  Service.account(this.name, this.accountId, this.accountPw);
  Service.payment(
      this.name, this.accountId, this.accountPw,
      this.paymentType, this.paymentDetail, this.paymentNext);
  Service.membership(
      this.name, this.accountId, this.accountPw,
      this.membershipType, this.membershipCost);

  void getPayment(String? paymentType, String? paymentDetail, String? paymentNext) {
    this.paymentType = paymentType;
    this.paymentDetail = paymentDetail;
    this.paymentNext = paymentNext;
  }
  void getMembership(int? membershipType, int? membershipCost) {
    this.membershipType = membershipType;
    this.membershipCost = membershipCost;
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
  void dbOpen() async {
    if(!opening) {
      databasePath = await getDatabasesPath();
      String path = join(databasePath, dbName + '.db');
      db = await openDatabase(path, version: 1);
      opening = true;
      debugPrint('Success to open db!');
    }
  }
  void dbClose() async {
    if(opening) {
      db.close();
      opening = false;
      debugPrint('Success to close db!');
    }
  }
  void dbEliminate() async {
    if(opening) {
      await db.close();
      await deleteDatabase(databasePath);
      debugPrint('Success to eliminate db!');
    }
    else {
      error('Db isn\'t opened!');
    }
  }
  void dbCreate();
  void dbInsert(dynamic data);
  void dbDelete();
  void dbUpdate();
  dynamic dbSelect();
}