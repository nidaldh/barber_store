import 'package:json_annotation/json_annotation.dart';

part 'document.model.g.dart';

enum Type { income, outcome }

@JsonSerializable()
class Document {
  Type type;
  String subType;
  double amount;
  String date;
  String? note;

  Document(
      {required this.type,
      required this.subType,
      required this.amount,
      required this.date,
      this.note});
}
