// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Photo$Impl _$$Photo$ImplFromJson(Map<String, dynamic> json) => _$Photo$Impl(
      description: json['alt_description'] as String,
      urls: PhotoUrls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$Photo$ImplToJson(_$Photo$Impl instance) =>
    <String, dynamic>{
      'alt_description': instance.description,
      'urls': instance.urls,
    };
