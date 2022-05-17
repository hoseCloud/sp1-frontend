import 'package:flutter/material.dart';
import 'package:flutterapp/global.dart';

class DbService extends Db {
  DbService() {
    dbName = 'Service';
  }

  @override
  void dbCreate() {
    db.execute('''
      CREATE TABLE "Service" (
        "name"	TEXT NOT NULL,
        "accoutId"	TEXT NOT NULL,
        "accountPw"	TEXT NOT NULL,
        "paymentType"	TEXT,
        "paymentDetail"	TEXT,
        "paymentNext"	TEXT,
        "membershipType"	INTEGER,
        "membershipCost"	INTEGER,
        PRIMARY KEY("name","accoutId")
      )
      '''
    );
    debugPrint('Success to create db!');
  }
  @override
  void dbInsert(dynamic data) async {
    if(opening) {
      await db.transaction((txn) async {
        int id = await txn.rawInsert('''
          INSERT INTO "main"."Service"(
          "name", "accoutId", "accountPw", 
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
  void dbDelete() {}
  @override
  void dbUpdate() {}
  @override
  dynamic dbSelect() async {
    dynamic result = await db.query('Service');
    /*
    late dynamic list;

    list = List.generate(result.length, (i) => {
      result[i]['name'],
      result[i]['account'],
    });

    debugPrint(list.toString());
    */

    return result;
  }
}