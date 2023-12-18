import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/clean_architecture/domain/use_cases/advice_use_case.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit({required this.useCase}) : super(const AdviceStateInitial());

  final AdviceUseCase useCase;

  Future<void> fetchRandom() async {
    emit(const AdviceStateLoading());
    final result = await useCase.read();

    emit(AdviceStateLoaded(id: result.id, advice: result.advice));
  }
}
