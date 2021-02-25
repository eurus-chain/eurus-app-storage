import 'package:flutter/material.dart';

import 'table_field_model.dart';

class DBTableModel {
  DBTableModel({
    @required this.tableName,
    @required this.fields,
    this.orgFields,
  });

  final String tableName;
  final List<TableFieldModel> fields;

  /// Support only add new fields
  final List<TableFieldModel> orgFields;

  String get tableQuery => _genCreateTableQuery();
  String get migrateQuery => _genMigrateQuery();

  // Generate SQL to create table
  String _genCreateTableQuery() {
    String query = 'CREATE TABLE $tableName(';

    String prefix = '';
    fields.forEach((e) {
      query += '$prefix${e.name} ${e.type}';
      if (e.isPK == true) query += ' PRIMARY KEY';

      prefix = ' ,';
    });

    query += ')';
    return query;
  }

  // Generate SQL to update table
  String _genMigrateQuery() {
    if (orgFields == null) return '';

    String fields = '';
    orgFields.forEach((e) {
      fields += fields == '' ? e.name : ', ${e.name}';
    });

    String query =
        'INSERT INTO $tableName($fields) SELECT $fields FROM old_$tableName';

    return query;
  }
}
