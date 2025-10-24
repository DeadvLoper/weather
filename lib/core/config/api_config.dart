import 'package:weather/core/config/env.dart';
import 'package:weather/core/constants/api_json_constants.dart' as a;
import 'package:weather/core/constants/json_constants.dart' as c;

class ApiConfig {
  static const String baseUrl = 'http://api.weatherapi.com/v1';
  const ApiConfig();

  static String currentWeather(String location, {bool airQuality = false}) {
    return '$baseUrl/current.json?key=${Env.apiKey}&q=$location&aqi=no';
  }

  static String getWeatherForecast(
    String location, {
    bool airQuality = false,
    int days = 1,
  }) {
    return '$baseUrl/forecast.json?key=${Env.apiKey}&q=$location&aqi=no&days=$days';
  }

  // This is to convert the received json from api to be used with model
  // The json from api as too many unnecessary fields

  static Map<String, dynamic> toModelCompatibleJson(Map<String, dynamic> json) {
    return {
      c.id: 0,
      c.city: json[a.location][a.name],
      c.temperature: {
        c.celsius: json[a.current][a.tempC],
        c.fahrenheit: json[a.current][a.tempF],
        c.condition: json[a.current][a.condition]['text'],
      },
      a.forecastDay: json[a.forecast][a.forecastDay],
      c.isDay: json[a.current][a.isDay] == 1,
      c.time: json[a.location][a.localtime],
    };
  }
}
