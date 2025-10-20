import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_theme.dart';
import 'package:weather/models/weather_data.dart';

class WeatherExpandableWidget extends StatelessWidget {
  const WeatherExpandableWidget({required this.weatherData}) : super(key: null);
  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * .9,
        maxWidth: MediaQuery.of(context).size.width * .9,
        minHeight: 100,
        maxHeight: 110,
      ),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // weatherData.city,
                  'New York',
                  style: AppTheme.textTheme.titleLarge!.copyWith(
                    color: AppTheme.onPrimary,
                    fontSize: 30,
                  ),
                ),
                Text(
                  weatherData.temperature.condition,
                  style: AppTheme.textTheme.bodyLarge!.copyWith(
                    color: AppTheme.onPrimary,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${weatherData.temperature.celsius.toStringAsFixed(0)}\u00B0',
            style: AppTheme.textTheme.bodyLarge!.copyWith(
              color: AppTheme.onPrimary,
              fontSize: 33,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
