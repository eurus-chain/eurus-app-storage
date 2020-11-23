import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageKit {
  final _storage = FlutterSecureStorage();

  /// Read a [String] variable from Secure Storage with the key of [key]
  ///
  /// Reture [value] in [String] if value was found
  /// Return [null] if is empty
  Future<String> readValue(String key) async {
    String value = await _storage.read(key: key);
    return value;
  }

  /// Write a variable [val] to Secure Storage with the key of [key]
  ///
  /// Return [true] after writing the variable to Secure Storage
  Future<bool> setValue(String val, String key) async {
    await _storage.write(key: key, value: val);
    return true;
  }

  /// Delete variable with the key of [key]
  ///
  /// Return [true] after deleting hte variable in Secure Storage
  Future<bool> deleteValue(String key) async {
    await _storage.delete(key: key);
    return true;
  }

  /// Delete all variable in Secure Storage
  ///
  /// return [true] after deleting all variables
  Future<bool> deleteAll() async {
    await _storage.deleteAll();

    return true;
  }
}
