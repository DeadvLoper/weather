import 'package:weather/core/constants/json_constants.dart' as c;

class Temperature {
  final double celsius;
  final double fahrenheit;
  final String condition;

  const Temperature({
    required this.celsius,
    required this.fahrenheit,
    required this.condition,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      celsius: json[c.celsius],
      fahrenheit: json[c.fahrenheit],
      condition: json[c.condition],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      c.celsius: celsius,
      c.fahrenheit: fahrenheit,
      c.condition: condition,
    };
  }
}

class HourForecast {
  final List<Hour> forecast;
  const HourForecast({required this.forecast});
}

class Hour {}
