abstract class DBRecord {
  DBRecord({required this.id});

  final dynamic id;

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>();
  }
}
