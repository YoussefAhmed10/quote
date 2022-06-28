import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qoutes/core/usecases/usecase.dart';
import 'package:qoutes/core/utils/app_string.dart';
import 'package:qoutes/features/splash/domain/usecases/change_locale.dart';
import 'package:qoutes/features/splash/domain/usecases/get_save_lang.dart';

part 'local_state.dart';

class LocaleCubit extends Cubit<LocalStates> {
  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLocaleUseCase changeLocale;
  LocaleCubit({required this.getSavedLangUseCase, required this.changeLocale})
      : super(const ChangeLocaleState(Locale(AppString.englishCode)));

  static LocaleCubit get(context) => BlocProvider.of(context);

  String? currentLang = AppString.englishCode;
  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParmes());
    response.fold(
        (failuer) => debugPrint(AppString.cacheFailuer),
        (value) => {
              currentLang = value,
              emit(ChangeLocaleState(Locale(currentLang!)))
            });
  }

  Future<void> _changeLang({required String langCode}) async {
    final response = await changeLocale.call(langCode);
    response.fold(
        (failuer) => debugPrint(AppString.cacheFailuer),
        (value) => {
              currentLang = langCode,
              emit(ChangeLocaleState(Locale(currentLang!)))
            });
  }

  void toEnglish() => _changeLang(langCode: AppString.englishCode);
  void toArbic() => _changeLang(langCode: AppString.arbicCode);
}
