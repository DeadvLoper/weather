import 'package:weather/core/config/env.dart';
import 'package:weather/core/constants/api_json_constants.dart' as a;
import 'package:weather/core/constants/json_constants.dart' as j;

class ApiConfig {
  static const String baseUrl = 'http://api.weatherapi.com/v1';
  const ApiConfig();

  static String currentWeather(String location, {bool airQuality = false}) {
    return '$baseUrl/current.json?key=${Env.apiKey}&q=$location&aqi=no';
  }

  // This is to convert the received json from api to be used with model
  // The json from api as too many unnecessary fields

  static Map<String, dynamic> toModelCompatibleJson(Map<String, dynamic> json) {
    return {
      j.city: json[a.location][a.name],
      j.temperature: {
        j.celsius: json[a.current][a.tempC],
        j.fahrenheit: json[a.current][a.tempF],
        j.condition: json[a.current][a.condition]['text'],
      },
    };
  }
}
