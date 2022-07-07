import 'dart:math';

import 'package:app_storage_kit/app_storage_kit.dart';
import 'package:flutter/material.dart';

import 'dummy_data_models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Storage Kit Demo',
      home: AppStorageKitDemo(),
    );
  }
}

class AppStorageKitDemo extends StatefulWidget {
  AppStorageKitDemo({Key? key}) : super(key: key);

  @override
  AppStorageKitDemoState createState() => AppStorageKitDemoState();
}

class AppStorageKitDemoState extends State<AppStorageKitDemo> {
  Map<String, String> _localNstorage = {};
  Map<String, String> _nstorage = {};
  Map<String, String> _localSstorage = {};
  Map<String, String> _sstorage = {};
  Map<String, String> _localDstorage = {};
  Map<String, String> _dstorage = {};

  late DatabaseStorageKit _db;

  @override
  void initState() {
    DBTableModel table = DBTableModel(
      tableName: 'testing_table',
      fields: [
        TableFieldModel(name: 'id', type: 'TEXT', isPK: true),
        TableFieldModel(name: 'value', type: 'TEXT'),
      ],
    );
    _db = DatabaseStorageKit(table: table);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Storage Kit Demo'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Normal Storage Test",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            key: Key('ns_add_val'),
                            child: Text("Add All"),
                            onPressed: _nsAddVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('ns_read_val'),
                            child: Text("Read All"),
                            onPressed: _nsReadVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('ns_delete_val'),
                            child: Text("Delete All"),
                            onPressed: _nsDeleteVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('ns_clear'),
                            child: Text("Clear"),
                            onPressed: _nsClear,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: this
                                    .genTextArray(_localNstorage, 'ns-local'),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: this.genTextArray(_nstorage, 'ns'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Secure Storage Test",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            key: Key('ss_add_val'),
                            child: Text("Add All"),
                            onPressed: _ssAddVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('ss_read_val'),
                            child: Text("Read All"),
                            onPressed: _ssReadVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('ss_delete_val'),
                            child: Text("Delete All"),
                            onPressed: _ssDeleteVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('ss_clear'),
                            child: Text("Clear"),
                            onPressed: _ssClear,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: this
                                    .genTextArray(_localSstorage, 'ss-local'),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: this.genTextArray(_sstorage, 'ss'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Database Storage Test",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            key: Key('db_add_val'),
                            child: Text("Add All"),
                            onPressed: _dbAddVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('db_read_val'),
                            child: Text("Read All"),
                            onPressed: _dbReadVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('db_delete_val'),
                            child: Text("Delete All"),
                            onPressed: _dbDeleteVal,
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            key: Key('db_clear'),
                            child: Text("Clear"),
                            onPressed: _dbClear,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: this
                                    .genTextArray(_localDstorage, 'db-local'),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: this.genTextArray(_dstorage, 'db'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _nsAddVal() async {
    String val = _randomValue();
    String key = "key-${_localNstorage.length + 1}";

    await NormalStorageKit().setValue(val, key);
    setState(() {
      _localNstorage.addAll({key: val});
    });
  }

  void _nsReadVal() async {
    this._localNstorage.forEach((key, value) async {
      String? dummyVal = await NormalStorageKit().readValue(key);

      if (dummyVal != null)
        setState(() {
          _nstorage.addAll({key: dummyVal});
        });
    });
  }

  void _nsDeleteVal() async {
    this._localNstorage.forEach((key, value) async {
      await NormalStorageKit().deleteValue(key);
    });

    setState(() {
      _nstorage = {};
    });
  }

  void _nsClear() async {
    await NormalStorageKit().deleteAll();

    setState(() {
      _nstorage = {};
      _localNstorage = {};
    });
  }

  void _ssAddVal() async {
    String val = _randomValue();
    String key = "key-${_localSstorage.length + 1}";

    await SecureStorageKit().setValue(val, key);
    setState(() {
      _localSstorage.addAll({key: val});
    });
  }

  void _ssReadVal() async {
    this._localSstorage.forEach((key, value) async {
      String? dummyVal = await SecureStorageKit().readValue(key);

      if (dummyVal != null)
        setState(() {
          _sstorage.addAll({key: dummyVal});
        });
    });
  }

  void _ssDeleteVal() async {
    this._localSstorage.forEach((key, value) async {
      await SecureStorageKit().deleteValue(key);
    });

    setState(() {
      _sstorage = {};
    });
  }

  void _ssClear() async {
    await SecureStorageKit().deleteAll();

    setState(() {
      _sstorage = {};
      _localSstorage = {};
    });
  }

  void _dbAddVal() async {
    String val = _randomValue();
    String key = "key-${_localDstorage.length + 1}";
    DummyRecordModel r = DummyRecordModel(id: key)..value = val;

    await _db.setRecord(r);
    if (r.value != null && r.value!.isNotEmpty)
      setState(() {
        _localDstorage.addAll({key: r.value!});
      });
  }

  void _dbReadVal() async {
    this._localDstorage.forEach((key, value) async {
      List<Map<String, dynamic>> vs =
          await _db.getRecords(where: 'id = ?', whereArgs: [key]);

      String? val = vs.length > 0 ? vs.first['value'] : null;

      if (val != null)
        setState(() {
          _dstorage.addAll({key: val});
        });
    });
  }

  void _dbDeleteVal() async {
    this._localDstorage.forEach((key, value) async {
      await _db.deleteRecord(where: 'id = ?', whereArgs: [key]);

      setState(() {
        _dstorage = {};
      });
    });
  }

  void _dbClear() async {
    await _db.clearTable();

    setState(() {
      _dstorage = {};
      _localDstorage = {};
    });
  }

  String _randomValue() {
    final rand = Random();
    final codeUnits = List.generate(12, (index) {
      return rand.nextInt(26) + 65;
    });

    return String.fromCharCodes(codeUnits);
  }

  List<Text> genTextArray(Map<String, String> dataSet, String tag) {
    List<Text> textArray = [];

    int counter = 1;
    dataSet.forEach((key, value) {
      textArray.add(Text(
        "$counter: $value",
        key: Key("$tag-$counter"),
      ));
      counter++;
    });

    return textArray;
  }
}
