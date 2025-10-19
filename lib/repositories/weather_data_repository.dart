import 'package:weather/models/sub_models.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/services/weather_data_source.dart';

final WeatherData dummy = WeatherData(
  city: 'Los Angeles',
  temperature: Temperature(celsius: 23, fahrenheit: 70, condition: 'Raining'),
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
