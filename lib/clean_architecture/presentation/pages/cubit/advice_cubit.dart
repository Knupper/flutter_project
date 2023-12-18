import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit() : super(const AdviceStateInitial());

  Future<void> fetchRandom() async {
    emit(const AdviceStateLoading());

    Future.delayed(
      Duration(seconds: 2),
      () => emit(
        AdviceStateLoaded(id: 42, advice: 'Die Antwort auf alles.'),
      ),
    );
    Future.delayed(
      Duration(seconds: 6),
      () => emit(
        AdviceStateError(errorMessage: 'FEHLER!!'),
      ),
    );
  }
}
