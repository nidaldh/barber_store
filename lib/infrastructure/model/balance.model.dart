import 'package:json_annotation/json_annotation.dart';

part 'balance.model.g.dart';

@JsonSerializable()
class BalanceModel {
  double? amount;
  double? income;
  double? outcome;

  BalanceModel({this.amount, this.income, this.outcome});

  factory BalanceModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceModelToJson(this);

  @override
  String toString() {
    return 'BalanceModel{amount: $amount}';
  }

  factory BalanceModel.fromMap(Map? data) => BalanceModel(
        amount: double.parse(data!['amount'] ?? '0.0'),
        income: double.parse(data['income'] ?? '0.0'),
        outcome: double.parse(data['outcome'] ?? '0.0'),
      );
}
