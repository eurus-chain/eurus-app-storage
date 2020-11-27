import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("App Storage Demo", () {
    FlutterDriver driver;
    TestingPageObj pageObj;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      pageObj = TestingPageObj(driver);

      await pageObj.clearAll();
    });

    tearDownAll(() async {
      if (driver != null) {
        await pageObj.clearAll();
        driver.close();
      }
    });

    test("Add new values to Storages", () async {
      await pageObj.addValue();
      await pageObj.readValue();
      await pageObj.verifyValue();
    });

    test("Read and delete values from Storages", () async {
      await pageObj.readValue();
      await pageObj.verifyValue();

      await pageObj.deleteValue();
      await pageObj.readValue();

      await pageObj.verifyValuNull();
    });

    // test("Add new values to Secure Storage", () async {});

    // test("Read and delete values from Secure Storage", () async {});
  });
}

class TestingPageObj {
  TestingPageObj(this.driver);

  final FlutterDriver driver;

  final _nsAddValBtn = find.byValueKey('ns_add_val');
  final _nsReadValBtn = find.byValueKey('ns_read_val');
  final _nsDeleteValBtn = find.byValueKey('ns_delete_val');
  final _nsClear = find.byValueKey('ns_clear');

  final _ssAddValBtn = find.byValueKey('ss_add_val');
  final _ssReadValBtn = find.byValueKey('ss_read_val');
  final _ssDeleteValBtn = find.byValueKey('ss_delete_val');
  final _ssClear = find.byValueKey('ss_clear');

  Future clearAll() async {
    await driver.tap(_nsClear);
    await driver.tap(_ssClear);
  }

  Future addValue() async {
    await driver.tap(_nsAddValBtn);
    await driver.tap(_nsAddValBtn);
    await driver.tap(_ssAddValBtn);
    await driver.tap(_ssAddValBtn);
  }

  Future readValue() async {
    await driver.tap(_nsReadValBtn);
    await driver.tap(_ssReadValBtn);
  }

  Future deleteValue() async {
    await driver.tap(_nsDeleteValBtn);
    await driver.tap(_ssDeleteValBtn);
  }

  Future verifyValue() async {
    expect(await driver.getText(find.byValueKey('ns-1')),
        await driver.getText(find.byValueKey('ns-local-1')));
    expect(await driver.getText(find.byValueKey('ss-1')),
        await driver.getText(find.byValueKey('ss-local-1')));
  }

  Future verifyValuNull() async {
    expect(await driver.getText(find.byValueKey('ns-1')), '1: null');
    expect(await driver.getText(find.byValueKey('ss-1')), '1: null');
  }
}
