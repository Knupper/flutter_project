import 'package:json_annotation/json_annotation.dart';

part 'advice_dto.g.dart';

@JsonSerializable()
class AdviceDto {
  @JsonKey(name: 'advice_id')
  final int id;
  final String advice;

  AdviceDto({required this.id, required this.advice});

  factory AdviceDto.fromJson(Map<String, dynamic> json) => _$AdviceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AdviceDtoToJson(this);
}
