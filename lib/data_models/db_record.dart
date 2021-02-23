import 'package:flutter/material.dart';

abstract class DBRecord {
  DBRecord({this.id});

  @required
  final dynamic id;

  DBRecord fromJson(Map<String, dynamic> r) {
    return null;
  }

  Map<String, dynamic> toJson() {
    return null;
  }
}
