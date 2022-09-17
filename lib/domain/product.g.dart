// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String?,
    )
      ..localUserId = json['local_user_id'] as String?
      ..disabled = json['disabled'] as bool?;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'local_user_id': instance.localUserId,
      'disabled': instance.disabled,
    };
