// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      name: json['name'] as String?,
    )..disabled = json['disabled'] as bool?;

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'name': instance.name,
      'disabled': instance.disabled,
    };
