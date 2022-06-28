import 'package:qoutes/core/utils/app_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LangLocalDataSource {
  Future<bool> changeLang({required String langCode});
  Future<String?> getSavedLang();
}

class LangLocalDataSourceImpl implements LangLocalDataSource {
  final SharedPreferences sharedPreferences;

  LangLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<bool> changeLang({required String langCode}) async =>
      sharedPreferences.setString(AppString.locale, langCode);

  @override
  Future<String?> getSavedLang() async =>
      sharedPreferences.containsKey(AppString.locale)
          ? sharedPreferences.getString(AppString.locale)
          : AppString.englishCode;
}
