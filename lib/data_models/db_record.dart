abstract class DBRecord {
  DBRecord({required this.id});

  final dynamic id;

  DBRecord.fromJson(Map<String, dynamic> r) : id = r['id'];

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>();
  }
}
