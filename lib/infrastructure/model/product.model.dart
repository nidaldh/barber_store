import 'package:json_annotation/json_annotation.dart';

part 'product.model.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel(this.barcode,this.name, this.salePrice, this.costPrice, this.quantity);

  String barcode;
  String name;
  double salePrice;
  double costPrice;
  int quantity;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  String toString() {
    return 'ProductModel{barcode: $barcode, name: $name, salePrice: $salePrice, costPrice: $costPrice, quantity: $quantity}';
  }
}
