import 'package:json_annotation/json_annotation.dart';

part 'document.model.g.dart';

enum Type { income, outcome }

@JsonSerializable()
class DocumentModel extends Comparable<DocumentModel> {
  String? id;
  Type type;
  String category;
  String? subCategory;
  double amount;
  String date;
  String dateMicroseconds;
  String? note;
  String name;

  DocumentModel(
      {required this.type,
      required this.name,
      required this.category,
      required this.amount,
      required this.date,
      required this.dateMicroseconds,
      this.note,
      this.id,
      this.subCategory});

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentModelToJson(this);

  @override
  String toString() {
    return 'Document{type: $type, category: $category, amount: $amount, date: $date, note: $note}';
  }

  @override
  int compareTo(DocumentModel other) {
    return dateMicroseconds.toInt() - other.dateMicroseconds.toInt();
  }
}

extension on String {
  int toInt() {
    return int.parse(this);
  }
}
