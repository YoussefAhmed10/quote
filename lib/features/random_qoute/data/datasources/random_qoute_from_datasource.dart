import 'package:qoutes/core/api/api_consumer.dart';
import 'package:qoutes/core/api/end_points.dart';
import 'package:qoutes/features/random_qoute/data/models/qoute_model.dart';

abstract class RandomQouteFromRemoteDataSource {
  Future<QuoteModel> getrandomQoute();
}

class RandomQouteFromRemoteDataSourcelmp
    implements RandomQouteFromRemoteDataSource {
  ApiConsumer apiConsumer;

  RandomQouteFromRemoteDataSourcelmp({required this.apiConsumer});
  @override
  Future<QuoteModel> getrandomQoute() async {
    final response = await apiConsumer.get(EndPoints.randomQoute);
    return QuoteModel.fromJson(response);
  }
}
