import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_theme.dart';
import 'package:weather/models/weather_data.dart';

class WeatherExpandedWidget extends StatelessWidget {
  const WeatherExpandedWidget({required this.weatherData, super.key});
  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      constraints: BoxConstraints(
        minHeight: height * .65,
        maxHeight: height * .65,
        minWidth: width * .9,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(weatherData.temperature.celsius.toStringAsFixed(0)),
      ),
    );
  }
}
