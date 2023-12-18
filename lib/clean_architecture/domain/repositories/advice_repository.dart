import 'package:flutter_project/clean_architecture/data/dto/advice_dto.dart';

abstract class AdviceRepository {
  Future<AdviceDto> read({String id = ''});
  // all other crud / needed backend functions
}
