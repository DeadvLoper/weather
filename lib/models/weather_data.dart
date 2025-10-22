import 'package:weather/core/constants/api_json_constants.dart' as a;
import 'package:weather/core/constants/json_constants.dart' as c;
import 'package:weather/models/sub_models.dart';

class WeatherData {
  final String city;
  final Temperature temperature;
  final HoursForecast hoursForecast;
  final DateTime time;
  final bool isDay;

  const WeatherData({
    required this.city,
    required this.temperature,
    required this.hoursForecast,
    required this.time,
    required this.isDay,
  });
}

class WeatherDataModel extends WeatherData {
  const WeatherDataModel({
    required super.city,
    required super.temperature,
    required super.hoursForecast,
    required super.time,
    required super.isDay,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      city: json[c.city],
      temperature: Temperature.fromJson(json[c.temperature]),
      hoursForecast: HoursForecast.fromJson(json[a.forecastDay][0]),
      time: DateTime.parse(json[c.time]),
      isDay: json[c.isDay],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      c.city: city,
      c.temperature: temperature.toJson(),
      a.forecastDay: hoursForecast.toJson(),
      c.isDay: isDay,
      c.time: time.toString(),
    };
  }
}
