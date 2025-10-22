import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/core/theme/app_theme.dart';
import 'package:weather/models/weather_data.dart';

class WeatherExpandableWidget extends StatelessWidget {
  const WeatherExpandableWidget({required this.weatherData}) : super(key: null);
  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * .9,
        maxWidth: MediaQuery.of(context).size.width * .9,
        minHeight: 100,
        maxHeight: 110,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: weatherData.isDay ? AppTheme.secondary : AppTheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherData.city,
                  style: AppTheme.textTheme.titleLarge!.copyWith(
                    color: AppTheme.onPrimary,
                    fontSize: 30,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  weatherData.temperature.condition,
                  style: AppTheme.textTheme.bodyLarge!.copyWith(
                    color: AppTheme.onPrimary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/icons/${weatherData.isDay ? 'day' : 'night'}.svg',
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
        ],
      ),
    );
  }
}
