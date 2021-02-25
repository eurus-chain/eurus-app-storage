import 'package:app_storage_kit/data_models/db_record.dart';
import 'package:app_storage_kit/data_models/db_table_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseStorageKit {
  static Database _db;
  static String _dbPath;

  final DBTableModel table;

  bool get dbReady => _db != null;

  DatabaseStorageKit({this.table});

  /// Initialize Database
  Future<Null> initDB() async {
    _dbPath = await getDatabasesPath();
    _db = await openDatabase(_dbPath + '/appStorageDB.db', version: 1);
    await _createTable();
  }

  /// Create Table in DB
  Future<bool> _createTable() async {
    bool createSuccess = true;
    if (await _ckTableExists()) return createSuccess;
    try {
      await _db.execute(table.tableQuery);
    } catch (e, t) {
      print("$e - $t");
      createSuccess = false;
    }
    return createSuccess;
  }

  /// Check if Table already created
  Future<bool> _ckTableExists() async {
    List<Map<String, dynamic>> response = await _db.query("sqlite_master",
        where: 'type = ? AND name = ?', whereArgs: ['table', table.tableName]);

    if (response.length <= 0) return false;

    if (response[0]['sql'] != table.tableQuery) await _udpateTable();

    return true;
  }

  Future<bool> _udpateTable() async {
    String tempOldTableName = 'old_${table.tableName}';

    try {
      await _db.execute('DROP TABLE $tempOldTableName');
    } catch (e, t) {
      print('$e - $t');
    }

    await _db
        .execute('ALTER TABLE ${table.tableName} RENAME TO $tempOldTableName');
    await _db.execute(table.tableQuery);
    await _db.execute(table.migrateQuery);
    await _db.execute('DROP TABLE $tempOldTableName');

    return true;
  }

  /// Set / update record
  Future<int> setRecord(DBRecord r, {bool updateIfExists}) async {
    if (!dbReady) await initDB();
    int response = await _db.insert(table.tableName, r.toJson(),
        conflictAlgorithm: updateIfExists == false
            ? ConflictAlgorithm.abort
            : ConflictAlgorithm.replace);

    return response;
  }

  /// Read records
  Future<List<Map<String, dynamic>>> getRecords({
    String where,
    List<dynamic> whereArgs,
    int limit,
    int offset,
    String order,
  }) async {
    if (!dbReady) await initDB();

    List<Map<String, dynamic>> records = await _db.query(
      table.tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: order,
      limit: limit,
      offset: offset,
    );

    return records;
  }

  /// Delete record
  Future<int> deleteRecord({String where, List<dynamic> whereArgs}) async {
    if (!dbReady) await initDB();

    int response =
        await _db.delete(table.tableName, where: where, whereArgs: whereArgs);

    return response;
  }

  /// Clear records from table
  Future<int> clearTable() async {
    int response = await _db.delete(table.tableName);

    return response;
  }

  /// Drop table
  Future<void> dropTable() async {
    await _db.execute("DROP TABLE IF EXISTS ${table.tableName}");
    return;
  }
}
