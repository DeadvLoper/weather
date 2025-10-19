import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/repositories/weather_data_repository.dart';

import 'weather_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<WeatherDataRepository>()])
void main() {
  test('tests weather repository', () async {
    final WeatherDataRepository repository = MockWeatherDataRepository();

    when(
      repository.fetchCurrentWeatherData('Los Angeles'),
    ).thenAnswer((_) => Future.value(dummy));

    expect(
      await repository
          .fetchCurrentWeatherData('Los Angeles')
          .then((d) => d.city),
      dummy.city,
    );
  });
}
