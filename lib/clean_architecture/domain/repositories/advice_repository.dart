import 'package:flutter_project/clean_architecture/core/failure.dart';
import 'package:flutter_project/clean_architecture/domain/entities/advice_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdviceRepository {
  Future<Result<AdviceEntity, Failure>> read({String id = ''});
  // all other crud / needed backend functions
}
