import 'dart:math';

import 'package:flutter_project/clean_architecture/core/failure.dart';
import 'package:flutter_project/clean_architecture/data/dto/advice_dto.dart';
import 'package:flutter_project/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_project/clean_architecture/domain/repositories/advice_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdviceRepositoryMock implements AdviceRepository {
  final List<AdviceDto> adviceList = List.generate(
    100,
    (index) => AdviceDto(advice: 'advice $index', id: index),
  );

  @override
  Future<Result<AdviceEntity, Failure>> read({String id = ''}) {
    int selectedId = 0;

    if (id.isEmpty) {
      final random = Random();
      selectedId = random.nextInt(adviceList.length);
    } else {
      selectedId = int.parse(id);
    }

    final dto = adviceList[selectedId];
    final entity = AdviceEntity(advice: dto.advice, id: dto.id);

    return Future.value(Success(entity));
  }
}
