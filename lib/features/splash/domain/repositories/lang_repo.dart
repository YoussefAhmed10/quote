import 'package:dartz/dartz.dart';
import 'package:qoutes/core/error/failuer.dart';

abstract class LangRepo {
  Future<Either<Failuer, bool>> changeLang({required String langCode});
  Future<Either<Failuer, String?>> getSavedLang();
}
