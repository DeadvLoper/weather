import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/core/theme/app_theme.dart';
import 'package:weather/models/sub_models.dart';
import 'package:weather/models/weather_data.dart';

class WeatherExpandedWidget extends StatefulWidget {
  const WeatherExpandedWidget({required this.weatherData, super.key});
  final WeatherData weatherData;

  @override
  State<WeatherExpandedWidget> createState() => _WeatherExpandedWidgetState();
}

class _WeatherExpandedWidgetState extends State<WeatherExpandedWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.weatherData.isDay ? AppTheme.secondary : AppTheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.weatherData.city,
              style: AppTheme.textTheme.titleLarge!.copyWith(
                fontSize: 33,
                letterSpacing: 1,
                color: AppTheme.onPrimary,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 25,
                        top: 25,
                        child: SvgPicture.asset(
                          'assets/icons/${widget.weatherData.isDay ? 'day' : 'night'}.svg',
                          fit: BoxFit.cover,
                          height: 100,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: animationController!.view,
                        builder: (context, _) {
                          return Text(
                            (widget.weatherData.temperature.celsius *
                                    animationController!.value)
                                .toStringAsFixed(0),
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              color: AppTheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * .25,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.weatherData.temperature.condition,
                  style: AppTheme.textTheme.titleLarge!.copyWith(
                    color: AppTheme.onPrimary,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            _buildForecastRow(widget.weatherData),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastRow(WeatherData weatherData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final Hour hour
            in weatherData.hoursForecast.getNextFourHoursForecast(
              weatherData.time.hour,
            ))
          _buildForecastWidget(hour),

        // IconButton(
        //   onPressed: () {
        //     animationController?.reset();
        //     animationController?.forward();
        //   },
        //   icon: Icon(Icons.play_arrow, color: Colors.white),
        // ),
      ],
    );
  }

  Widget _buildForecastWidget(Hour hour) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Positioned(
              right: 0,
              child: SvgPicture.asset(
                'assets/icons/${hour.time.hour >= 20 ? 'night' : 'day'}.svg',
              ),
            ),
            Text(
              '${hour.celsius.toStringAsFixed(0)}\u00B0',
              style: TextStyle(
                fontFamily: 'BebasNeue',
                fontWeight: FontWeight.bold,
                fontSize: 44,
                color: AppTheme.onPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          '${hour.time.hour}:00',
          style: TextStyle(
            fontFamily: 'BebasNeue',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppTheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
