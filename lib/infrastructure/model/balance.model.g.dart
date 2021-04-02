// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceModel _$BalanceModelFromJson(Map<String, dynamic> json) {
  return BalanceModel(
    amount: (json['amount'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$BalanceModelToJson(BalanceModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
    };
