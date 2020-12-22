import 'package:flutter_test/flutter_test.dart';

import 'package:app_storage_kit/app_storage_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String key1 = 'key1';
  String key2 = 'key2';

  String nsVal1 = 'Normal Storage Val 1';
  String nsVal2 = 'Normal Storage Val 2';

  group('Normal Storage CRUD', () {
    SharedPreferences.setMockInitialValues({});

    test('Set and read values into normal storage', () async {
      String val1 = await NormalStorageKit().readValue(key1);
      String val2 = await NormalStorageKit().readValue(key2);
      expect(val1, null);
      expect(val2, null);
      bool setState1 = await NormalStorageKit().setValue(nsVal1, key1);
      bool setState2 = await NormalStorageKit().setValue(nsVal2, key2);
      expect(setState1, true);
      expect(setState2, true);
      val1 = await NormalStorageKit().readValue(key1);
      val2 = await NormalStorageKit().readValue(key2);
      expect(val1, nsVal1);
      expect(val2, nsVal2);
    });

    test('Delete values from normal storage', () async {
      String val1 = await NormalStorageKit().readValue(key1);
      String val2 = await NormalStorageKit().readValue(key2);
      expect(val1, nsVal1);
      expect(val2, nsVal2);
      bool delState1 = await NormalStorageKit().deleteValue(key1);
      bool delState2 = await NormalStorageKit().deleteValue(key2);
      expect(delState1, true);
      expect(delState2, true);
      val1 = await NormalStorageKit().readValue(key1);
      val2 = await NormalStorageKit().readValue(key2);
      expect(val1, null);
      expect(val2, null);
    });
  });
}
