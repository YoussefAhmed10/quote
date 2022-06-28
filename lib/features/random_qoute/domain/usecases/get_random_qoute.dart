import 'package:dartz/dartz.dart';
import 'package:qoutes/core/error/failuer.dart';
import 'package:qoutes/core/usecases/usecase.dart';
import 'package:qoutes/features/random_qoute/domain/entities/qoute.dart';
import 'package:qoutes/features/random_qoute/domain/repositories/qoute_repo.dart';

class GetRandomQoute implements UseCase<Qoute, NoParmes> {
  final QouteRepo qouteRepo;

  GetRandomQoute({required this.qouteRepo});
  @override
  Future<Either<Failuer, Qoute>> call(NoParmes parmes) {
    return qouteRepo.getRandomQoute();
  }
}
