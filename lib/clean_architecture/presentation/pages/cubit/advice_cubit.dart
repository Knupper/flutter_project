import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/clean_architecture/core/failure.dart';
import 'package:flutter_project/clean_architecture/domain/use_cases/advice_use_case.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit({required this.useCase}) : super(const AdviceStateInitial());

  final AdviceUseCase useCase;

  String _id = '';

  Future<void> fetchRandom() async {
    emit(const AdviceStateLoading());
    final result = await useCase.read();

    result.when(
      (success) => emit(AdviceStateLoaded(id: success.id, advice: success.advice)),
      (error) => emit(AdviceStateError(failure: error)),
    );
  }

  Future<void> fetch() async {
    emit(const AdviceStateLoading());
    final result = await useCase.read(id: _id);

    result.when(
      (success) => emit(AdviceStateLoaded(id: success.id, advice: success.advice)),
      (error) => emit(AdviceStateError(failure: error)),
    );
  }

  Future<void> idChanged({required String id}) async {
    if (int.tryParse(id) == null) {
      // todo error handling
    } else {
      _id = id;
    }
  }
}
