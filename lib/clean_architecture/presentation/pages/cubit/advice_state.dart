part of 'advice_cubit.dart';

sealed class AdviceState {
  const AdviceState();
}

class AdviceStateInitial extends AdviceState {
  const AdviceStateInitial();
}

class AdviceStateLoading extends AdviceState {
  const AdviceStateLoading();
}

class AdviceStateError extends AdviceState {
  const AdviceStateError({required this.failure});

  final Failure failure;
}

class AdviceStateLoaded extends AdviceState {
  const AdviceStateLoaded({
    required this.id,
    required this.advice,
  });

  final String advice;
  final int id;
}
