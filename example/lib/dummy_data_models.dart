import 'package:app_storage_kit/app_storage_kit.dart';

class DummyRecordModel extends DBRecord {
  DummyRecordModel({this.id}) : super(id: id);

  final String id;
  String value;

  DummyRecordModel.fromJson(Map<String, dynamic> r)
      : id = r['id'],
        value = r['value'];

  @override
  Map<String, dynamic> toJson() => {'id': id, 'value': value};
}
