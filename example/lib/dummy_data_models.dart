import 'package:app_storage_kit/app_storage_kit.dart';

class DummyRecordModel extends DBRecord {
  DummyRecordModel({required this.id, this.value}) : super(id: id);

  final String id;
  String? value;

  @override
  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}
