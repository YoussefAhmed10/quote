import 'dart:convert';

import 'package:qoutes/core/error/failuer.dart';
import 'package:qoutes/core/utils/app_string.dart';
import 'package:qoutes/features/random_qoute/data/models/qoute_model.dart';
import 'package:qoutes/features/random_qoute/domain/entities/qoute.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RandomQouteFromLocalDataSource {
  Future<Qoute> getLastRandomQoute();
  Future<void> cacheQoute(QuoteModel qoute);
}

class RadnomQouteLocalDataSourceImpl implements RandomQouteFromLocalDataSource {
  final SharedPreferences sharedPreferences;

  RadnomQouteLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Qoute> getLastRandomQoute() {
    final jsonString = sharedPreferences.getString(AppString.cashRandomQoute);
    if (jsonString != null) {
      final localQouteCache =
          Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return localQouteCache;
    } else {
      throw CachFailuer();
    }
  }

  @override
  Future<void> cacheQoute(QuoteModel qoute) {
    return sharedPreferences.setString(
        AppString.cashRandomQoute, json.encode(qoute));
  }
}
