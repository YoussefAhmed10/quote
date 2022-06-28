import 'package:qoutes/core/error/exeption.dart';
import 'package:qoutes/core/network/netwok_info.dart';
import 'package:qoutes/features/random_qoute/data/datasources/random_qoute_from_datasource.dart';
import 'package:qoutes/features/random_qoute/data/datasources/random_qoute_local_datasource.dart';
import 'package:qoutes/features/random_qoute/domain/entities/qoute.dart';
import 'package:qoutes/core/error/failuer.dart';
import 'package:dartz/dartz.dart';
import 'package:qoutes/features/random_qoute/domain/repositories/qoute_repo.dart';

class QouteRepoImpl implements QouteRepo {
  final NetworkInfo networkInfo;
  final RandomQouteFromRemoteDataSource remoteDataSource;
  final RandomQouteFromLocalDataSource localDataSource;

  QouteRepoImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failuer, Qoute>> getRandomQoute() async {
    // if (await networkInfo.isConnected) {
    try {
      final rmoteRandomQoute = await remoteDataSource.getrandomQoute();
      localDataSource.cacheQoute(rmoteRandomQoute);
      return Right(rmoteRandomQoute);
    } on ServerException {
      return Left(ServerFailuer());
    }
  }
  // else {
  //   try {
  //     final cacheRandomQoute = await localDataSource.getLastRandomQoute();
  //     return Right(cacheRandomQoute);
  //   } on CacheException {
  //     return Left(CachFailuer());
  //   }
  // }
  // }
}
