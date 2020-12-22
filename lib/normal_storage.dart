import 'package:shared_preferences/shared_preferences.dart';

class NormalStorageKit {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /// Write a [String] variable [val] to Share Preference with the key [key]
  ///
  /// Return [result] in [bool] after writing the variable in Share Preference
  Future<bool> setValue(String val, String key) async {
    final SharedPreferences prefs = await _prefs;
    bool result = await prefs.setString(key, val);

    return result;
  }

  /// Read a [String] variable from Share Preference with the key [key]
  ///
  /// Return [value] in [String] if value was found
  /// Return [null] if is empty
  Future<String> readValue(String key) async {
    final SharedPreferences prefs = await _prefs;
    String value = prefs.getString(key);

    return value;
  }

  /// Delete variable with the key [key]
  ///
  /// Return [result] in [bool] after removing the variable in Share Preference
  Future<bool> deleteValue(String key) async {
    final SharedPreferences prefs = await _prefs;
    bool result = await prefs.remove(key);

    return result;
  }

  /// Delete all variable stored in Share Preference
  ///
  /// return [result] in [bool] after deleting all variables
  Future<bool> deleteAll() async {
    final SharedPreferences prefs = await _prefs;
    bool result = await prefs.clear();

    return result;
  }
}
