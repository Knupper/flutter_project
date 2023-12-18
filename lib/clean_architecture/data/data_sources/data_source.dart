import 'package:flutter_project/clean_architecture/data/dto/advice_dto.dart';

abstract class DataSource {
  Future<AdviceDto> read({String id = ''});
}
