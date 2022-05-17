import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

Scaffold loading() {
  return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 200,
      ),
    ),
  );
}

class Service {
  String name;
  String account;
  Service(this.name, this.account);
}

abstract class Db {
  late final String dbName;
  bool opening = false;
  late String databasePath;
  late List<dynamic> field;
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

class DbService extends Db {
  DbService() {
    dbName = 'Service';
    field = [['name', 'TEXT'], ['account', 'TEXT']];
  }

  @override
  void dbCreate() {
    db.execute(
        'CREATE TABLE "$dbName" ('
            '"${field[0][0]}" ${field[0][1]} NOT NULL,'
            '"${field[1][0]}"	${field[1][1]} NOT NULL,'
            'PRIMARY KEY("${field[0][0]}","${field[1][0]}")'
            ')'
      /*
      'CREATE TABLE "Service" ('
        '"name"     TEXT NOT NULL,'
        '"account"	TEXT NOT NULL,'
        'PRIMARY KEY("name","account")'
      ')'
      */
    );
    debugPrint('Success to create db!');
  }
  @override
  void dbInsert(dynamic data) async {
    if(opening) {
      await db.transaction((txn) async {
        int id = await txn.rawInsert(
            'INSERT INTO $dbName("${field[0][0]}","${field[1][0]}") VALUES(?, ?)',
            [data.name, data.account]
          /*
          'INSERT INTO Service("name","account") VALUES(?, ?)',
          */
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
    late dynamic list;

    list = List.generate(result.length, (i) => {
      result[i]['name'],
      result[i]['account'],
    });
    debugPrint(list.toString());

    return list;
  }
}

