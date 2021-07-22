import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageKit {
  /// Write a [String] variable [val] to Secure Storage with the key [key]
  ///
  /// Return [true] after writing the variable to Secure Storage
  Future<bool> setValue(String val, String key) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: key, value: val);
    return true;
  }

  /// Read a [String] variable from Secure Storage with the key [key]
  ///
  /// Reture [value] in [String] if value was found
  /// Return [null] if is empty
  Future<String?> readValue(String key) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    String? value = await storage.read(key: key);
    return value;
  }

  /// Delete variable with the key [key]
  ///
  /// Return [true] after deleting the variable in Secure Storage
  Future<bool> deleteValue(String key) async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: key);
    return true;
  }

  /// Delete all variable in Secure Storage
  ///
  /// return [true] after deleting all variables
  Future<bool> deleteAll() async {
    final FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.deleteAll();
    return true;
  }
}
