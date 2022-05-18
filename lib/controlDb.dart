import 'package:flutter/material.dart';
import 'package:flutterapp/global.dart';

class DbService extends Db {
  DbService() {
    dbName = 'Service';
  }

  @override
  Future<void> dbCreate() async {
    await db.execute('''
      CREATE TABLE "Service" (
        "name"	TEXT NOT NULL,
        "accountId"	TEXT NOT NULL,
        "accountPw"	TEXT NOT NULL,
        "paymentType"	TEXT,
        "paymentDetail"	TEXT,
        "paymentNext"	TEXT,
        "membershipType"	INTEGER,
        "membershipCost"	INTEGER,
        PRIMARY KEY("name","accountId")
      )
      '''
    );
    debugPrint('Success to create db!');
  }
  @override
  Future<void> dbInsert(dynamic data) async {
    if(opening) {
      await db.transaction((txn) async {
        int id = await txn.rawInsert('''
          INSERT INTO "main"."Service"(
          "name", "accountId", "accountPw", 
          "paymentType", "paymentDetail", "paymentNext", 
          "membershipType", "membershipCost")
          VALUES (?, ?, ?, ?, ?, ?, ?, ?);
          ''',
          [data.name, data.accountId, data.accountPw,
           data.paymentType, data.paymentDetail, data.paymentNext,
           data.membershipType, data.membershipCost]
        );
        debugPrint('Success to insert: $id');
      });
    }
    else {
      error('DbService isn\'t opened!');
    }
  }
  @override
  Future<void> dbDelete() async {}
  @override
  Future<void> dbUpdate() async {}
  @override
  Future<dynamic> dbSelect() async {
    dynamic result = await db.query('Service');
    List<Service> list = [];
/*
    for(int i = 0; i < result.length; i++) {
      list.add(
          Service(
            result[i]['name'],
            result[i]['accountId'],
            result[i]['accountPw'],
            result[i]['paymentType'],
            result[i]['paymentDetail'],
            result[i]['paymentNext'],
            result[i]['membershipType'],
            result[i]['membershipCost'],
          )
      );
    }
*/
    return result;
  }
}