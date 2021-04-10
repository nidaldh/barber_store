// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    barcode: json['barcode'] as String,
    name: json['name'] as String,
    salePrice: (json['salePrice'] as num?)?.toDouble(),
    costPrice: (json['costPrice'] as num?)?.toDouble(),
    quantity: json['quantity'] as int,
    storeQuantity: json['storeQuantity'] as int?,
  )..error = json['error'] as String?;
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'name': instance.name,
      'salePrice': instance.salePrice,
      'costPrice': instance.costPrice,
      'quantity': instance.quantity,
      'error': instance.error,
      'storeQuantity': instance.storeQuantity,
    };
