import 'package:app_storage_kit/data_models/db_record.dart';
import 'package:app_storage_kit/data_models/db_table_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseStorageKit {
  static Database _db;
  static String _dbPath;

  final DBTableModel table;

  bool get dbReady => _db != null;

  DatabaseStorageKit({this.table}) {
    _initDB().then((value) => _createTable(table));
  }

  static Future<Null> _initDB() async {
    _dbPath = await getDatabasesPath();
    _db = await openDatabase(_dbPath + 'appStorageDB.db', version: 1);
  }

  /// Create Table in DB
  Future<bool> _createTable(DBTableModel table) async {
    bool createSuccess = true;
    if (await _ckTableExists(table.tableName)) return createSuccess;
    try {
      await _db.execute(table.tableQuery);
    } catch (e) {
      createSuccess = false;
    }
    return createSuccess;
  }

  /// Check if Table already created
  Future<bool> _ckTableExists(String tableName) async {
    List<Map<String, dynamic>> response = await _db.query("sqlite_master",
        where: 'type = ? AND name = ?', whereArgs: ['table', tableName]);

    return response.length > 0 ? true : false;
  }

  /// Set / update record
  Future<int> setRecord(DBRecord r, {bool updateIfExists}) async {
    int response = await _db.insert(table.tableName, r.toJson(),
        conflictAlgorithm: updateIfExists == false
            ? ConflictAlgorithm.abort
            : ConflictAlgorithm.replace);

    return response;
  }

  Future<List<Map<String, dynamic>>> getRecords(
      {String where, List<dynamic> whereArgs}) async {
    List<Map<String, dynamic>> records =
        await _db.query(table.tableName, where: where, whereArgs: whereArgs);

    return records;
  }

  /// Delete record
  Future<int> deleteRecord({String where, List<dynamic> whereArgs}) async {
    int response =
        await _db.delete(table.tableName, where: where, whereArgs: whereArgs);

    return response;
  }

  /// Clear records from table
  Future<int> clearTable() async {
    int response = await _db.delete(table.tableName);

    return response;
  }
}
