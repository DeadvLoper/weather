import 'package:dio/dio.dart';
import 'package:weather/core/config/api_config.dart';
import 'package:weather/core/failure/failure.dart';
import 'package:weather/models/weather_data.dart';

class WeatherDataSource {
  final Dio _dio = Dio();
  Future<WeatherData> fetchCurrentWeatherData(String location) async {
    try {
      final response = await _dio.getUri<Map<String, dynamic>>(
        Uri.parse(ApiConfig.getWeatherForecast(location,days: 2)),
      );

      if (response.data == null) throw NoResult;
      return WeatherDataModel.fromJson(
        ApiConfig.toModelCompatibleJson(response.data!),
      );
    } catch (e) {
      rethrow;
    }
  }
}
