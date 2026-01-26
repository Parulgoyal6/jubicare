import 'dart:io';

import 'package:jublicare/data/models/imagePojo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as dbPath;


class Databasehelper {

static Database? _database;
static const String _dbName = "jubicare.db";
static const int _dbVersion = 1;

Databasehelper._privateConstructor();

static final Databasehelper instance = Databasehelper._privateConstructor();

Future<Database> get database async {
  if (_database != null) return _database!;

  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = dbPath.join(documentsDirectory.path, _dbName);

  _database = await openDatabase(
    path,
    version: _dbVersion,
    onCreate: _onCreate,
    onUpgrade: _onUpgrade,
  );

  return _database!;
}

Future<void>_onCreate(Database db, int version)async{
await db.execute(Imagepojo.createTable);
}

Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {

  }
}

  Future<int> insertData(Map<String, dynamic>mapList, String table) async {
    Database? db = await database;
    return await db!.insert(table, mapList);
  }

}