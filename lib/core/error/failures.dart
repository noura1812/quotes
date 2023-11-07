import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String message;
  const Failures({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    return message;
  }
}

class ServerFailure extends Failures {
  const ServerFailure({required super.message});
}

class CachedFailure extends Failures {
  const CachedFailure({required super.message});
}
