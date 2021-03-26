// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document(
    type: json['type'] as String,
    subType: json['subType'] as String,
    amount: (json['amount'] as num).toDouble(),
    date: json['date'] as String,
    note: json['note'] as String?,
  );
}

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'type': instance.type,
      'subType': instance.subType,
      'amount': instance.amount,
      'date': instance.date,
      'note': instance.note,
    };
