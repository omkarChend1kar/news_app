import 'package:equatable/equatable.dart';

/// Failures abstract class for List of properties failures
abstract class Failures extends Equatable {
  final String? message;

  const Failures({required this.message});

  @override
  List<Object?> get props => [];
}

/// General Failures
/// this class is used to show Server Failures
class ServerFailure extends Failures {
  const ServerFailure({String? message}) : super(message: message ?? '');
}

/// this class is used to show cache failures
class CacheFailure extends Failures {
  const CacheFailure({String? message}) : super(message: message ?? '');
}

/// this class is used to show network failures
class NetworFailure extends Failures {
  const NetworFailure({String? message}) : super(message: message ?? '');
}
