import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/config/api_config.dart';
import 'package:weather/core/errors/errors.dart';
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

        // Diffrence in minutes
        final difference = DateTime.now()
            .difference(time)
            .inMinutes
            .remainder(60)
            .remainder(60);
        if (difference < 5) {
          // last cache has to be atleast five minutes to make a new call
          return await localSource.loadFromCache();
        }
      }

      // Otherwise fetch from api
      final response = await _dio.getUri<Map<String, dynamic>>(
        Uri.parse(ApiConfig.getWeatherForecast(location, days: 2)),
      );

      if (response.data == null) throw NoResultsFound;

      final WeatherData weatherData = WeatherDataModel.fromJson(
        ApiConfig.toModelCompatibleJson(response.data!),
      );

      return await localSource.addToCache(weatherData);
    } on SocketException {
      throw NoInternetConnection;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
