abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryPrameter});
  Future<dynamic> post(String path,
      {Map<String, dynamic>? queryPrameter, Map<String, dynamic>? body});
  Future<dynamic> update(String path,
      {Map<String, dynamic>? queryPrameter, Map<String, dynamic>? body});
}
