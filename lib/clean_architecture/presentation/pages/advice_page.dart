import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/clean_architecture/domain/repositories/advice_repository.dart';
import 'package:flutter_project/clean_architecture/domain/use_cases/advice_use_case.dart';
import 'package:flutter_project/clean_architecture/presentation/components/error_card.dart';
import 'package:flutter_project/clean_architecture/presentation/pages/cubit/advice_cubit.dart';

class AdvicePageProvider extends StatelessWidget {
  const AdvicePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdviceCubit>(
      create: (context) => AdviceCubit(
        useCase: AdviceUseCase(repository: context.read<AdviceRepository>()),
      ),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdviceCubit, AdviceState>(
      listenWhen: (previous, current) => current is AdviceStateError,
      listener: (context, state) {
        if (state is AdviceStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.failure.toString(),
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Container(
                color: Colors.blueGrey,
                width: 500,
                height: 500,
                child: Center(
                  child: BlocBuilder<AdviceCubit, AdviceState>(
                    builder: (context, state) {
                      debugPrint('$state');
                      switch (state) {
                        case AdviceStateInitial _:
                          return const Text('Please press the button below.');
                        case AdviceStateLoading _:
                          return const CircularProgressIndicator();
                        case AdviceStateError error:
                          return ErrorCard(failure: error.failure);
                        case AdviceStateLoaded loaded:
                          return Text('[${loaded.id}] - ${loaded.advice}');
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            OutlinedButton(
              onPressed: () => context.read<AdviceCubit>().fetchRandom(),
              child: const Text('Get random data'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => context.read<AdviceCubit>().idChanged(id: value),
            ),
            OutlinedButton(
              onPressed: () => context.read<AdviceCubit>().fetch(),
              child: const Text('Get advice'),
            ),
          ],
        ),
      ),
    );
  }
}
