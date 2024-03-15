import 'package:equatable/equatable.dart';

/// Failures abstract class for List of properties failures
abstract class Failures extends Equatable {
  final String? message;
  final String? errorCode;
  final String? statusCode;
  final String? errorDescription;

  const Failures({
    required this.errorCode,
    required this.message,
    required this.errorDescription,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [
        message,
        statusCode,
        errorDescription,
        errorCode,
      ];
}

/// General Failures
/// this class is used to show Server Failures
class ServerFailure extends Failures {
  const ServerFailure({
    super.errorCode,
    super.message,
    super.errorDescription,
    super.statusCode,
  });
}

/// this class is used to show cache failures
class CacheFailure extends Failures {
  const CacheFailure({
    super.errorCode,
    super.message,
    super.errorDescription,
    super.statusCode,
  });
}

/// General Failures
/// this class is used to show network Failures
class NetworkFailure extends Failures {
  const NetworkFailure({
    super.errorCode,
    super.message,
    super.errorDescription,
    super.statusCode,
  });
}
