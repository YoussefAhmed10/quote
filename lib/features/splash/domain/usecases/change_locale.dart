import 'package:qoutes/core/error/failuer.dart';
import 'package:dartz/dartz.dart';
import 'package:qoutes/core/usecases/usecase.dart';
import 'package:qoutes/features/splash/domain/repositories/lang_repo.dart';

class ChangeLocaleUseCase implements UseCase<bool, String> {
  final LangRepo langRepo;
  ChangeLocaleUseCase({required this.langRepo});
  @override
  Future<Either<Failuer, bool?>> call(String locale) async {
    return await langRepo.changeLang(langCode: locale);
  }
}
