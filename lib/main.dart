import 'package:flutter/material.dart';
import 'package:weather/core/classes/app_state.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/provider/weather_data_provider.dart';
import 'package:weather/repositories/weather_data_repository.dart';
import 'package:weather/ui/widgets/weather_expandable_widget.dart';
import 'package:weather/ui/widgets/weather_expanded_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    WeatherDataProvider(
      repository: WeatherDataRepositoryImpl(),
      child: MaterialApp(
        home: Scaffold(body: Center(child: const WeatherApp())),
      ),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppState<WeatherData>? appState = WeatherDataProvider.of(
      context,
    ).appState;
    return switch (appState) {
      DataState(:final weatherData) => WeatherExpandedWidget(
        weatherData: weatherData,
      ),
      ErrorState() => Text('An Error Occurred!'),
      LoadingState() => const Center(child: CircularProgressIndicator()),
      null => const Center(child: CircularProgressIndicator()),
    };
  }
}
