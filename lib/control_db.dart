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
        "paymentNext"	INTEGER,
        "membershipType"	INTEGER,
        "membershipCost"	INTEGER,
        PRIMARY KEY("name","accountId")
      )
      ''');
    debugPrint('Success to create db!');
  }

  @override
  Future<void> dbInsert(dynamic data) async {
    if (opening) {
      await db.transaction((txn) async {
        int id = await txn.rawInsert(
          '''
          INSERT INTO "main"."Service"(
          "name", "accountId", "accountPw",
          "paymentType", "paymentDetail", "paymentNext",
          "membershipType", "membershipCost")
          VALUES (?, ?, ?, ?, ?, ?, ?, ?);
          ''',
          [
            data.name,
            data.accountId,
            data.accountPw,
            data.paymentType,
            data.paymentDetail,
            data.paymentNext,
            data.membershipType,
            data.membershipCost
          ],
        );
        debugPrint('Success to insert: $id');
      });
    } else {
      error('DbService isn\'t opened!');
    }
  }

  @override
  Future<void> dbDelete(dynamic data) async {
    if (opening) {
      await db.transaction((txn) async {
        int id = await txn.rawInsert(
          'DELETE FROM "Service" WHERE "name" = ? AND "accountId" = ?',
          [data.name, data.accountId],
        );
        debugPrint('Success to delete: $id');
      });
    } else {
      error('DbService isn\'t opened!');
    }
  }

  @override
  Future<void> dbUpdate() async {}
  @override
  Future<dynamic> dbSelect() async {
    return await db.query('Service');
  }

  Future<dynamic> deSelect(String name, String accountId) async {
    return await db.rawQuery('SELECT * FROM "Service" WHERE '
        '"name" = "$name" AND "accountId" = "$accountId"');
  }
}

class DbUser extends Db {
  DbUser() {
    dbName = 'User';
  }

  @override
  Future<void> dbCreate() async {
    await db.execute('''
      CREATE TABLE "User" (
        "id"	TEXT NOT NULL,
        "pw"	TEXT NOT NULL,
        "email"	TEXT NOT NULL,
        "auto"	INTEGER NOT NULL DEFAULT 0 CHECK("auto" == 0 OR "auto" == 1),
        PRIMARY KEY("id")
      );
      ''');
    debugPrint('[User] Success to create db!');
  }

  @override
  Future<void> dbInsert(dynamic data) async {
    if (opening) {
      await db.transaction((txn) async {
        int id = await txn.rawInsert(
          '''
          INSERT INTO "main"."User"(
          "id", "pw", "email", "auto")
          VALUES (?, ?, ?, ?);
          ''',
          [
            data.id,
            data.pw,
            data.email,
            data.auto,
          ],
        );
        debugPrint('[User] Success to insert: $id');
      });
    } else {
      error('[User] DbService isn\'t opened!');
    }
  }

  @override
  Future<void> dbDelete(dynamic data) async {
    if (opening) {
      await db.transaction((txn) async {
        int id = await txn.rawInsert(
          'DELETE FROM "User" WHERE "id" = ? AND "pw" = ?',
          [data.id, data.pw],
        );
        debugPrint('[User] Success to delete: $id');
      });
    } else {
      error('[User] DbService isn\'t opened!');
    }
  }

  @override
  Future<void> dbUpdate() async {}
  @override
  Future<dynamic> dbSelect() async {
    return await db.query('User');
  }

  Future<dynamic> dbIsAuto() {
    return db.rawQuery('SELECT * FROM "User" WHERE '
        '"auto" = 1');
  }
}
