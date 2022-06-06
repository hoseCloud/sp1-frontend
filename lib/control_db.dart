import 'package:flutter/material.dart';
import 'package:flutterapp/global.dart';

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
