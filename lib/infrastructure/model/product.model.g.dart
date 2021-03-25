// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    json['barcode'] as String?,
    json['name'] as String?,
    (json['salePrice'] as num?)?.toDouble(),
    (json['costPrice'] as num?)?.toDouble(),
    json['quantity'] as int?,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'name': instance.name,
      'salePrice': instance.salePrice,
      'costPrice': instance.costPrice,
      'quantity': instance.quantity,
    };
