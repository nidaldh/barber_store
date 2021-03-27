// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) {
  return DocumentModel(
    type: _$enumDecode(_$TypeEnumMap, json['type']),
    name: json['name'] as String,
    category: json['category'] as String,
    amount: (json['amount'] as num).toDouble(),
    date: json['date'] as String,
    note: json['note'] as String?,
    id: json['id'] as String?,
    dateMicroseconds: json['dateMicroseconds'] as String?,
  );
}

Map<String, dynamic> _$DocumentModelToJson(DocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TypeEnumMap[instance.type],
      'category': instance.category,
      'amount': instance.amount,
      'date': instance.date,
      'dateMicroseconds': instance.dateMicroseconds,
      'note': instance.note,
      'name': instance.name,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TypeEnumMap = {
  Type.income: 'income',
  Type.outcome: 'outcome',
};
