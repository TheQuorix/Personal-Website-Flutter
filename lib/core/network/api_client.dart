import 'package:dio/dio.dart';
import 'package:personal_website/core/models/info/info_model.dart';
import 'package:personal_website/core/models/visits/visit_stats_model.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://172.23.144.1:8080',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  Future<InfoModel> getInfo() async {
    try {
      final response = await _dio.get('/api/v1/info');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');
      return InfoModel.fromJson(response.data);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Ошибка загрузки: ${e.message}');
    }
  }

  Future<VisitStatsModel> getVisits() async {
    try {
      final response = await _dio.get('/api/v1/visits/stats');
      print('Status: ${response.statusCode}');
      print('Data: ${response.data}');
      return VisitStatsModel.fromJson(response.data);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Ошибка загрузки: ${e.message}');
    }
  }
}
