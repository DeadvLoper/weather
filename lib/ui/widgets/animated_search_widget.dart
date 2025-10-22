import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_theme.dart';
import 'package:weather/provider/weather_data_provider.dart';

class AnimatedSearchWidget extends StatefulWidget {
  const AnimatedSearchWidget({super.key, required this.onSelected});
  final void Function() onSelected;

  @override
  State<AnimatedSearchWidget> createState() => _AnimatedSearchWidgetState();
}

class _AnimatedSearchWidgetState extends State<AnimatedSearchWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  final TextEditingController textEditingController = TextEditingController();

  final List<String> cities = [
    'London',
    'Karachi',
    'Kharan',
    'Dubai',
    'Paris',
    'Lahore',
  ];

  List<String>? results;

  void search(String search) {
    results = cities
        .where((city) => city.toLowerCase().contains(search.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animationController?.forward();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: animationController!.view,
        curve: Curves.slowMiddle,
      ),

      builder: (context, _) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: animationController!.value,
          child: Transform.translate(
            offset: Offset(0, 100 - animationController!.value * 100),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 25,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (st) {
                        search(st);
                      },
                      autofocus: true,
                      cursorColor: AppTheme.onPrimary,
                      style: AppTheme.textTheme.bodyLarge!.copyWith(
                        color: AppTheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: AppTheme.textTheme.titleLarge!.copyWith(
                          color: AppTheme.onPrimary,
                        ),
                        filled: true,
                        fillColor: AppTheme.primary,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppTheme.onPrimary,
                            width: 5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.onPrimary),
                        ),
                      ),
                    ),
                    Container(
                      color: AppTheme.backgroundColor,
                      height: 250,
                      child: results == null
                          ? Center(
                              child: Text(
                                'Search for a place',
                                style: AppTheme.textTheme.titleLarge!.copyWith(
                                  color: AppTheme.onPrimary,
                                ),
                              ),
                            )
                          : results!.isEmpty
                          ? Center(
                              child: Text(
                                'No Places found!',
                                style: AppTheme.textTheme.titleLarge!.copyWith(
                                  color: AppTheme.onPrimary,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: results!.length,
                              itemBuilder: (ctx, index) {
                                return _buildResultText(results![index]);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultText(String resultText) {
    return Container(
      color: AppTheme.primary,
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Text(
            resultText,
            style: AppTheme.textTheme.bodyMedium!.copyWith(
              color: AppTheme.onPrimary,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
                widget.onSelected();
                WeatherDataProvider.of(context).searchCity(resultText.trim());
            },
            color: AppTheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
