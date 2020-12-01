# app_storage_kit

app_storage_kit is a plugin for application to use both Normal Storage (shared preferences) and Secure Storage (iOS: Keychain, Android: Keystore)

Normal Storage provided by [shared_preferences](https://pub.dev/packages/shared_preferences)

Secure Storage provided by [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)

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
## License
[MIT](https://choosealicense.com/licenses/mit/)
