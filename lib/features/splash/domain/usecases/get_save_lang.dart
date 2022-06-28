import 'package:qoutes/core/error/failuer.dart';
import 'package:dartz/dartz.dart';
import 'package:qoutes/core/usecases/usecase.dart';
import 'package:qoutes/features/splash/domain/repositories/lang_repo.dart';

class GetSavedLangUseCase implements UseCase<String, NoParmes> {
  final LangRepo langRepo;
  GetSavedLangUseCase({required this.langRepo});

  @override
  Future<Either<Failuer, String?>> call(NoParmes parmes) async =>
      await langRepo.getSavedLang();
}
