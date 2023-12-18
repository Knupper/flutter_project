import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_project/clean_architecture/domain/entities/advice_entity.dart';
import 'package:flutter_project/clean_architecture/domain/use_cases/advice_use_case.dart';
import 'package:flutter_project/clean_architecture/presentation/pages/cubit/advice_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';

class MockAdviceUseCase extends Mock implements AdviceUseCase {}

void main() {
  group('AdviceCubit', () {
    final AdviceUseCase mockUseCase = MockAdviceUseCase();

    blocTest(
      'advice cubit should fetch random data',
      setUp: () {
        when(() => mockUseCase.read()).thenAnswer(
          (invocation) => Future.value(
            Success(
              AdviceEntity(advice: 'test-42', id: 42),
            ),
          ),
        );
      },
      build: () => AdviceCubit(useCase: mockUseCase),
      act: (bloc) => bloc.fetchRandom(),
      expect: () => const [
        AdviceStateLoading(),
        AdviceStateLoaded(id: 42, advice: 'test-42'),
      ],
    );
  });
}
