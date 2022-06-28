import 'package:qoutes/core/error/exeption.dart';
import 'package:qoutes/core/error/failuer.dart';
import 'package:dartz/dartz.dart';
import 'package:qoutes/features/splash/data/datasources/lang_local_datasource.dart';
import 'package:qoutes/features/splash/domain/repositories/lang_repo.dart';

class LangRepoImpl implements LangRepo {
  final LangLocalDataSource langLocalDataSource;

  LangRepoImpl({required this.langLocalDataSource});
  @override
  Future<Either<Failuer, bool>> changeLang({required String langCode}) async {
    try {
      final langChanged =
          await langLocalDataSource.changeLang(langCode: langCode);
      return Right(langChanged);
    } on CacheException {
      return Left(CachFailuer());
    }
  }

  @override
  Future<Either<Failuer, String?>> getSavedLang() async {
    try {
      final langSaved = await langLocalDataSource.getSavedLang();
      return Right(langSaved);
    } on CacheException {
      return Left(CachFailuer());
    }
  }
}
