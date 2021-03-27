// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document(
    type: _$enumDecode(_$TypeEnumMap, json['type']),
    subType: json['subType'] as String,
    amount: (json['amount'] as num).toDouble(),
    date: json['date'] as String,
    note: json['note'] as String?,
  );
}

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'type': _$TypeEnumMap[instance.type],
      'subType': instance.subType,
      'amount': instance.amount,
      'date': instance.date,
      'note': instance.note,
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
