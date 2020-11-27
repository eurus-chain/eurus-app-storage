import 'dart:math';

import 'package:app_storage_kit/normal_storage.dart';
import 'package:app_storage_kit/secure_storage.dart';
import 'package:flutter/material.dart';

void main() {
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
  AppStorageKitDemo({Key key}) : super(key: key);

  @override
  AppStorageKitDemoState createState() => AppStorageKitDemoState();
}

class AppStorageKitDemoState extends State<AppStorageKitDemo> {
  Map<String, String> _localNstorage = {};
  Map<String, String> _nstorage = {};
  Map<String, String> _localSstorage = {};
  Map<String, String> _sstorage = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Storage Kit Demo'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Normal Storage Test",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    key: Key('ns_add_val'),
                    child: Text("Add All"),
                    onPressed: _nsAddVal,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    key: Key('ns_read_val'),
                    child: Text("Read All"),
                    onPressed: _nsReadVal,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    key: Key('ns_delete_val'),
                    child: Text("Delete All"),
                    onPressed: _nsDeleteVal,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    key: Key('ns_clear'),
                    child: Text("Clear"),
                    onPressed: _nsClear,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: this.genTextArray(_localNstorage, 'ns-local'),
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
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "Secure Storage Test",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    key: Key('ss_add_val'),
                    child: Text("Add All"),
                    onPressed: _ssAddVal,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    key: Key('ss_read_val'),
                    child: Text("Read All"),
                    onPressed: _ssReadVal,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    key: Key('ss_delete_val'),
                    child: Text("Delete All"),
                    onPressed: _ssDeleteVal,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    key: Key('ss_clear'),
                    child: Text("Clear"),
                    onPressed: _ssClear,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: this.genTextArray(_localSstorage, 'ss-local'),
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
          ],
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
      String dummyVal = await NormalStorageKit().readValue(key);

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
      String dummyVal = await SecureStorageKit().readValue(key);

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
