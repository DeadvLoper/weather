import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/config/api_config.dart';
import 'package:weather/core/failure/failure.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/services/weather_data_local_source.dart';

class WeatherDataSource {
  final Dio _dio = Dio();
  Future<WeatherData> fetchCurrentWeatherData(String location) async {
    try {
      final WeatherDataLocalSource localSource = WeatherDataLocalSourceImpl();
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      // Check last cache to avoid refetch
      String? lastCacheTimetext = sharedPreferences.getString('last-cache');
      if (lastCacheTimetext != null) {
        DateTime time = DateTime.parse(lastCacheTimetext);
        if (time
                .difference(DateTime.now())
                .inMinutes
                .remainder(60)
                .remainder(60) <
            5) {
          return await localSource.loadFromCache();
        }
      }

      // Otherwise fetch from api

      final response = await _dio.getUri<Map<String, dynamic>>(
        Uri.parse(ApiConfig.getWeatherForecast(location, days: 2)),
      );

      if (response.data == null) throw NoResult;
      final WeatherData weatherData = WeatherDataModel.fromJson(
        ApiConfig.toModelCompatibleJson(response.data!),
      );

      return await localSource.addToCache(weatherData);
    } catch (e) {
      rethrow;
    }
  }
}
