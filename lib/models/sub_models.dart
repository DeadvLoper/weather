import 'package:weather/core/constants/api_json_constants.dart' as a;
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

class HoursForecast {
  final List<Hour> forecast;
  const HoursForecast({required this.forecast});

  factory HoursForecast.fromJson(Map<String, dynamic> json) {
    return HoursForecast(
      forecast: List<Hour>.from(
        json[a.forecastDay]
            .map((hourJson) => Hour.formJson(hourJson))
            .toList(),
      ),
    );
  }

  List<Hour> getNextFourHoursForecast(int currentHour) {
    return forecast
        .where((hour) => hour.time.hour > currentHour)
        .take(4)
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      a.forecastHour: List<Map<String, dynamic>>.from(
        forecast.map((hour) => hour.toJson()).toList(),
      ),
    };
  }
}

class Hour {
  final double celsius;
  final double fahrenheit;
  final DateTime time;

  const Hour({
    required this.celsius,
    required this.fahrenheit,
    required this.time,
  });

  factory Hour.formJson(Map<String, dynamic> json) {
    return Hour(
      celsius: json[a.tempC],
      fahrenheit: json[a.tempF],
      time: DateTime.parse(json[a.time]),
    );
  }

  Map<String, dynamic> toJson() {
    return {a.tempC: celsius, a.tempF: fahrenheit, a.time: time.toString()};
  }
}
