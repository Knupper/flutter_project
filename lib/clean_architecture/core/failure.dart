import 'package:equatable/equatable.dart';

sealed class Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class TimeOutFailure extends Failure {}

class InvalidIdFailure extends Failure {}
