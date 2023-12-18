// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advice_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdviceDto _$AdviceDtoFromJson(Map<String, dynamic> json) => AdviceDto(
      id: json['advice_id'] as int,
      advice: json['advice'] as String,
    );

Map<String, dynamic> _$AdviceDtoToJson(AdviceDto instance) => <String, dynamic>{
      'advice_id': instance.id,
      'advice': instance.advice,
    };
