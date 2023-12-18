import 'package:flutter/material.dart';
import 'package:flutter_project/clean_architecture/core/failure.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key, required this.failure});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    String errorText = 'Standard error';

    switch (failure) {
      case ServerFailure():
        errorText = 'Fehler im Backend, wir arbeiten dran!';
        break;
      default:
        break;
    }

    return Card(
      color: Colors.red,
      child: Center(
        child: Text(
          errorText,
        ),
      ),
    );
  }
}
