import 'package:dartz/dartz.dart';
import 'package:qoutes/core/error/failuer.dart';
import 'package:qoutes/features/random_qoute/domain/entities/qoute.dart';

abstract class QouteRepo {
  Future<Either<Failuer, Qoute>> getRandomQoute();
}
