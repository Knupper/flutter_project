import 'package:flutter_project/clean_architecture/data/dtos/advice_dto.dart';

abstract class AdviceRepository {
  Future<AdviceDto> read();
  // all other crud / needed backend functions
}
