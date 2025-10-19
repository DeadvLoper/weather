import 'package:weather/core/constants/json_constants.dart' as c;
import 'package:weather/models/sub_models.dart';

class WeatherData {
  final String city;
  final Temperature temperature;

  const WeatherData({required this.city, required this.temperature});
}

class WeatherDataModel extends WeatherData {
  const WeatherDataModel({required super.city, required super.temperature});

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    return WeatherDataModel(
      city: json[c.city],
      temperature: Temperature.fromJson(json[c.temperature]),
    );
  }

  Map<String, dynamic> toJson() {
    return {c.city: city, c.temperature: temperature.toJson()};
  }
}
