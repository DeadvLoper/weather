import 'package:weather/models/sub_models.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/services/weather_data_remote_source.dart';

final WeatherDataModel dummy = WeatherDataModel(
  id: 0,
  city: '',
  temperature: Temperature(celsius: 0, fahrenheit: 0, condition: '.....'),
  hoursForecast: HoursForecast(
    forecast: [
      Hour(celsius: 0, fahrenheit: 0, time: DateTime.now()),
      Hour(celsius: 0, fahrenheit: 0, time: DateTime.now()),
      Hour(celsius: 0, fahrenheit: 0, time: DateTime.now()),
      Hour(celsius: 0, fahrenheit: 0, time: DateTime.now()),
    ],
  ),
  time: DateTime.now(),
  isDay: false,
);

abstract class WeatherDataRepository {
  Future<WeatherData> fetchCurrentWeatherData(String location);
}

class WeatherDataRepositoryImpl implements WeatherDataRepository {
  @override
  Future<WeatherData> fetchCurrentWeatherData(String location) async {
    final WeatherDataSource weatherDataSource = WeatherDataSource();
    return weatherDataSource.fetchCurrentWeatherData(location);
  }
}
