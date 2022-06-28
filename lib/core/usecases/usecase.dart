import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failuer.dart';

abstract class UseCase<Type, Parmes> {
  Future<Either<Failuer, Type?>> call(Parmes parmes);
}

class NoParmes extends Equatable {
  @override
  List<Object?> get props => [];
}
