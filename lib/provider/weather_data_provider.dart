import 'package:flutter/material.dart';
import 'package:weather/core/classes/app_state.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/repositories/weather_data_repository.dart';

class WeatherDataProvider extends StatefulWidget {
  const WeatherDataProvider({required this.repository, required this.child})
    : super(key: null);
  final WeatherDataRepository repository;
  final Widget child;

  @override
  State<WeatherDataProvider> createState() => WeatherProviderState();

  static WeatherProviderState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedWidget>()!
        .currentState;
  }
}

class WeatherProviderState extends State<WeatherDataProvider> {
  AppState<WeatherData>? appState;

  // Make first weather report request
  Future<void> initiateRequest() async {
    setState(() {
      appState = LoadingState();
    });
    appState = DataState(
      weatherData: await widget.repository.fetchCurrentWeatherData('London'),
    );
    setState(() {});
  }

  Future<void> searchCity(String city) async {
    setState(() {
      appState = LoadingState();
    });

    appState = DataState(
      weatherData: await widget.repository.fetchCurrentWeatherData(city),
    );
    setState(() {});
  }

  @override
  void initState() {
    initiateRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(currentState: this, child: widget.child);
  }
}

class _InheritedWidget extends InheritedWidget {
  final WeatherProviderState currentState;
  const _InheritedWidget({required this.currentState, required super.child});

  @override
  bool updateShouldNotify(_InheritedWidget old) {
    return true;
  }
}
