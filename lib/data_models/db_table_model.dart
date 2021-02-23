import 'table_field_model.dart';

class DBTableModel {
  DBTableModel({this.tableName, this.fields});

  final String tableName;
  final List<TableFieldModel> fields;

  String get tableQuery => _genCreateTableQuery();

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
}
