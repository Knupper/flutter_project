import 'dart:math';

import 'package:flutter_project/clean_architecture/data/dto/advice_dto.dart';
import 'package:flutter_project/clean_architecture/domain/repositories/advice_repository.dart';

class AdviceRepositoryMock implements AdviceRepository {
  final List<AdviceDto> adviceList = List.generate(
    100,
    (index) => AdviceDto(advice: 'advice $index', id: index),
  );

  @override
  Future<AdviceDto> read({String id = ''}) {
    int selectedId = 0;

    if (id.isEmpty) {
      final random = Random();
      selectedId = random.nextInt(adviceList.length);
    } else {
      selectedId = int.parse(id);
    }

    return Future.value(adviceList[selectedId]);
  }
}
