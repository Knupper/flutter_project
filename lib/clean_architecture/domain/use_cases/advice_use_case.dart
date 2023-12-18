import 'package:flutter_project/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_project/clean_architecture/domain/repositories/advice_repository.dart';

class AdviceUseCase {
  final AdviceRepository repository;

  AdviceUseCase({required this.repository});

  Future<AdviceEntity> read({String? id}) async {
    final result = await repository.read(id: id ?? '');

    return AdviceEntity(advice: result.advice, id: result.id);
  }

  Future<void> delete() async {}

  Future<void> create() async {}

  Future<void> update() async {}
}
