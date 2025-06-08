import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Dbhelper {
  Dbhelper._();

  static final Dbhelper getInstance = Dbhelper._();
  static final TABLE_NAME = "AllNotes";
  static final S_NO_COL = "S_NO";
  static final TITLE_COL = "TITLE";
  static final DESC_COL = "DESC";

  Database? myDB;

  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await openDB();
      return myDB!;
    }
  }

  Future<Database> openDB() async {
    Directory appPath = await getApplicationDocumentsDirectory();
    String dbPath = join(appPath.path, "notesDB.db");
    return await openDatabase(
      dbPath,
      onCreate: (db, version) {
        db.execute(
          "create table $TABLE_NAME ($S_NO_COL integer primary key autoincrement , $TITLE_COL text , $DESC_COL text)",
        );
      },
      version: 1,
    );
  }

  Future<bool> addNote({required String mTitle, required String mDesc}) async {
    var db = await getDB();

    int RowsAffected = await db.insert(TABLE_NAME, {
      TITLE_COL: mTitle,
      DESC_COL: mDesc,
    });

    return RowsAffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mdata = await db.query(TABLE_NAME);
    return mdata;
  }

  Future<bool> updateNote({
    required String title,
    required String desc,
    required int sno,
  }) async {
    var db = await getDB();
    int rowsEffected = await db.update(
      TABLE_NAME,
      {TITLE_COL: title, DESC_COL: desc},
      where: "$S_NO_COL = ?",
      whereArgs: [sno],
    );

    return rowsEffected > 0;
  }

  Future<bool> deleteNote({required int sno}) async {
    var db = await getDB();

    int rowsEffected = await db.delete(TABLE_NAME, where: "$S_NO_COL = $sno");
    return rowsEffected > 0;
  }

  Future<bool> deleteAllNotes() async {
    var db = await getDB();
    int rowsEffected = await db.delete(TABLE_NAME);
    return rowsEffected > 0;
  }
}
