import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather/core/classes/app_state.dart';
import 'package:weather/core/theme/app_theme.dart';
import 'package:weather/models/weather_data.dart';
import 'package:weather/provider/weather_data_provider.dart';
import 'package:weather/repositories/weather_data_repository.dart';
import 'package:weather/ui/widgets/stacked_widget.dart';
import 'package:weather/ui/widgets/weather_expandable_widget.dart';
import 'package:weather/ui/widgets/weather_expanded_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherDataProvider(
        repository: WeatherDataRepositoryImpl(),
        child: SafeArea(child: App()),
      ),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  ScrollController controller = ScrollController();

  bool isVisible = false;

  bool showButton = true;

  void _toggleVisiblity() => setState(() {
    animationController?.reset();
    animationController?.forward();
    isVisible = !isVisible;
  });

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    animationController?.forward();
    controller.addListener(() {
      if (controller.position.pixels + 10 >
          controller.position.maxScrollExtent) {
        showButton = false;
      } else {
        showButton = true;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: StackedWidget(
          isVisible: isVisible,
          onSelected: () {
            setState(() {
              isVisible = false;
            });
          },
          child: WeatherApp(controller: controller),
        ),
      ),
      floatingActionButton: showButton
          ? AnimatedBuilder(
              animation: animationController!.view,
              builder: (ctx, _) {
                return Transform.rotate(
                  angle:
                      ((180 * animationController!.value) -
                          (isVisible ? 0 : 180)) *
                      (180 / pi),
                  child: Transform.scale(
                    scale: animationController!.value,
                    child: FloatingActionButton(
                      backgroundColor: AppTheme.primary,
                      onPressed: _toggleVisiblity,
                      child: Icon(
                        isVisible ? Icons.add : Icons.search,
                        size: 33,
                        color: AppTheme.onPrimary,
                      ),
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key, required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final AppState<WeatherData>? appState = WeatherDataProvider.of(
      context,
    ).appState;
    return switch (appState) {
      DataState(:final weatherData) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 5),
        child: _buildWeatherWidgets(weatherData, controller: controller),
      ),

      ErrorState() => Text('An Error Occurred!'),
      LoadingState() => _buildWeatherWidgets(dummy),
      null => _buildWeatherWidgets(dummy),
    };
  }

  Widget _buildWeatherWidgets(
    WeatherData weatherData, {
    ScrollController? controller,
  }) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: WeatherExpandedWidget(weatherData: weatherData),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            controller: controller,
            children: [
              WeatherExpandableWidget(weatherData: weatherData),
              WeatherExpandableWidget(weatherData: weatherData),
              WeatherExpandableWidget(weatherData: weatherData),
            ],
          ),
        ),
      ],
    );
  }
}
