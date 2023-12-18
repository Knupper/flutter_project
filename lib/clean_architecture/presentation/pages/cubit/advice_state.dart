part of 'advice_cubit.dart';

sealed class AdviceState with EquatableMixin {
  const AdviceState();

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props => [failure];
}

class AdviceStateLoaded extends AdviceState {
  const AdviceStateLoaded({
    required this.id,
    required this.advice,
  });

  final String advice;
  final int id;

  @override
  List<Object?> get props => [advice, id];
}
