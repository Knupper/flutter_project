import 'dart:io';

import 'package:flutter_project/clean_architecture/core/failure.dart';
import 'package:flutter_project/clean_architecture/data/data_sources/rest_api_data_source.dart';
import 'package:flutter_project/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_project/clean_architecture/domain/repositories/advice_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdviceRepositoryRest implements AdviceRepository {
  final RestApiDataSource dataSource;

  AdviceRepositoryRest({required this.dataSource});

  @override
  Future<Result<AdviceEntity, Failure>> read({String id = ''}) async {
    try {
      final dto = await dataSource.read(id: id);
      final entity = AdviceEntity(advice: dto.advice, id: dto.id);

      return Success(entity);
    } on SocketException catch (_) {
      return Error(TimeOutFailure());
    } on Exception catch (_) {
      return Error(ServerFailure());
    }
  }
}
