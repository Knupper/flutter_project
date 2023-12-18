import 'dart:math';

import 'package:flutter_project/clean_architecture/data/dtos/advice_dto.dart';
import 'package:flutter_project/clean_architecture/domain/repositories/advice_repository.dart';

class AdviceRepositoryMock implements AdviceRepository {
  final List<AdviceDto> adviceList = List.generate(
    100,
    (index) => AdviceDto(advice: 'advice $index', id: index),
  );

  @override
  Future<AdviceDto> read() {
    final random = Random();
    final randomId = random.nextInt(adviceList.length);

    return Future.value(adviceList[randomId]);
  }
}
