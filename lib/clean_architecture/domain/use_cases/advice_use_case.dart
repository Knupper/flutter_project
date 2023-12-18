import 'package:flutter_project/clean_architecture/core/failure.dart';
import 'package:flutter_project/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_project/clean_architecture/domain/repositories/advice_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdviceUseCase {
  final AdviceRepository repository;

  AdviceUseCase({required this.repository});

  Future<Result<AdviceEntity, Failure>> read({String? id}) async {
    final int? parsedValue = int.tryParse(id ?? '');

    if ((parsedValue ?? 0) > 90) {
      return Error(InvalidIdFailure());
    } else {
      final result = await repository.read(id: id ?? '');

      return result;
    }
  }

  Future<void> delete() async {}

  Future<void> create() async {}

  Future<void> update() async {}
}
