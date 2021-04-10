import 'package:json_annotation/json_annotation.dart';

part 'product.model.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel(
      {required this.barcode,
      required this.name,
      this.salePrice,
      this.costPrice,
      required this.quantity,
      this.storeQuantity});

  String barcode;
  String name;
  double? salePrice;
  double? costPrice;
  int quantity;
  String? error;
  int? storeQuantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  factory ProductModel.fromMap(Map? data) => ProductModel(
        barcode: data!['barcode'],
        name: data['name'],
        salePrice: data['salePrice'],
        costPrice: data['costPrice'],
        quantity: data['quantity'],
        storeQuantity: data['quantity'],
      );

  @override
  String toString() {
    return 'ProductModel{barcode: $barcode, name: $name, salePrice: $salePrice, costPrice: $costPrice, quantity: $quantity}';
  }
}
