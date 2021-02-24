# app_storage_kit

app_storage_kit is a plugin for application to use both Normal Storage (shared preferences) and Secure Storage (iOS: Keychain, Android: Keystore)

Normal Storage provided by [shared_preferences](https://pub.dev/packages/shared_preferences)

Secure Storage provided by [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)

Database Storage provided by [sqflite](https://pub.dev/packages/sqflite)

## Usage
### Normal Storage
```dart
import 'package:app_storage_kit/normal_storage.dart';

/// Set value "Value" with key "Key" into shared preferences
///
/// Returns [bool]
/// Returns [true] indicates set value successful
await NormalStorageKit().setValue("Value", "Key");

/// Read value from shared preferences by key "Key" 
///
/// Returns [String]
/// Returns [Null] if no value was found under [key]
await NormalStorageKit().readValue("Key");

/// Delete value in shared preferences by key "Key"
///
/// Returns [bool]
/// Returns [true] indicates delete values successful 
await NormalStorageKit().deleteValue("Key");

/// Delete all values stored in shared preference
///
/// Returns [bool]
/// Returns [true] indicates delete all values successful
await NormalStorageKit().deleteAll();
```
### Secure Storage
```dart
import 'package:app_storage_kit/secure_storage.dart';

/// Set value "Value" with key "Key" into keychain/keystore
///
/// Returns [bool]
/// Returns [true] indicates set value successful
await SecureStorageKit().setValue("Value", "Key");

/// Read value from keychain/keystore by key "Key" 
///
/// Returns [String]
/// Returns [Null] if no value was found under [key]
await SecureStorageKit().readValue("Key");

/// Delete value in keychain/keystore by key "Key"
///
/// Returns [bool]
/// Returns [true] indicates delete values successful 
await SecureStorageKit().deleteValue("Key");

/// Delete all values stored in keychain/keystore
///
/// Returns [bool]
/// Returns [true] indicates delete all values successful
await SecureStorageKit().deleteAll();
```
### Database Storage
#### Create table structure
```dart
import 'package:app_storage_kit/data_models/db_record.dart';
import 'package:app_storage_kit/data_models/db_table_model.dart';

/// Create record type extends DBRecord class
class TestingRecordModel extends DBRecord {
    TestingRecordModel({this.id, this.value}) : super(id: id);

    final String id;
    String value;

    /// Convert data from JSON
    @override
    TestingRecordModel fromJson(Map<String, dynamic> r) => 
        TestingRecordModel(
            id: r['id'], 
            value: r['value'],
        );

    /// Convert data to JSON
    @override
    Map<String, dynamic> toJson() => {
        'id': id, 
        'value': value
    };
}

/// Set Table name and fields
DBTableModel table = DBTableModel(
    tableName: 'table_name',
    fields: [
    TableFieldModel(name: 'id', type: 'TEXT', isPK: true),
    TableFieldModel(name: 'value', type: 'TEXT'),
    ],
);

/// Open database with table
DatabaseStorageKit _db = DatabaseStorageKit(table: table);

/// Add value to table
TestingRecordModel r = TestingRecordModel(id: 'key', value: 'val');
await _db.setRecord(r);

/// Get all values from table
List<Map<String, dynamic>> records = await _db.getRecords();

/// Get values with given condition
List<Map<String, dynamic>> records = await _db.getRecords(where: 'id = ?', whereArgs: [key]);

/// Update value
///
/// Record will be updated for using the same id
r.value = 'val2';
await _db.setRecord(r);

/// Delete record with given condition
await _db.deleteRecord(where: 'id = ?', whereArgs: [key]);

/// Clear table
await _db.clearTable();
```
## License
[MIT](https://choosealicense.com/licenses/mit/)
