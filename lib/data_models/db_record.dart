import 'package:flutter/material.dart';

abstract class DBRecord {
  DBRecord({this.id});

  @required
  final dynamic id;

  DBRecord.fromJson(Map<String, dynamic> r) : id = r['id'];

  Map<String, dynamic> toJson() {
    return null;
  }
}
