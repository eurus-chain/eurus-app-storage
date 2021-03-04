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
  @deprecated
  final List<TableFieldModel> orgFields;

  String orgTableQuery;

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
    if (orgTableQuery == null) return '';

    Map<String, String> orgFields = _decodeOrgFields();
    Map<String, String> newFields = {};

    fields.forEach((e) {
      newFields.addAll({e.name: e.name});
    });

    String fieldsToMigrate = '';
    orgFields.forEach((key, v) {
      if (newFields[v] != null)
        fieldsToMigrate += fieldsToMigrate == '' ? v : ', $v';
    });

    String query =
        'INSERT INTO $tableName($fieldsToMigrate) SELECT $fieldsToMigrate FROM old_$tableName';

    return query;
  }

  // Decode original table fields
  Map<String, String> _decodeOrgFields() {
    Map<String, String> fieldList = {};

    RegExp onlyFieldsExp = RegExp(r'\((.+)\)');
    var onlyFieldsMatchs = onlyFieldsExp.allMatches(orgTableQuery);

    String match = onlyFieldsMatchs.elementAt(0).group(1);

    match = match.replaceAll(' PRIMARY KEY', '');

    RegExp removeTypeExp = RegExp(r'\s[A-Z]+');
    String removedTypes = match.replaceAll(removeTypeExp, '');

    List<String> fields = removedTypes.split(' ,');

    fields.forEach((e) {
      fieldList.addAll({e: e});
    });

    return fieldList;
  }
}
