import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/models/weather_data.dart';

import 'package:weather/core/constants/api_json_constants.dart' as a;
import 'package:weather/core/constants/json_constants.dart' as c;

abstract class WeatherDataLocalSource {
  Future<WeatherData> loadFromCache();
  Future<WeatherData> addToCache(WeatherData weatherData);
}

class WeatherDataLocalSourceImpl implements WeatherDataLocalSource {
  Future<Database> getDatabase() async {
    return await openDatabase(
      '${await getApplicationCacheDirectory()}/weatherdata.db',
      onCreate: (db, _) {
        db.execute(
          'CREATE TABLE WEATHERDATA(ID INTEGER PRIMARY KEY, CITY TEXT NOT NULL, TEMPERATURE TEXT NOT NULL, FORECAST TEXT NOT NULL, TIME TEXT, ISDAY BOOL NOT NULL)',
        );
        db.execute(
          'CREATE TABLE WATCHLIST(ID INTEGER PRIMARY KEY, CITY TEXT NOT NULL, TEMPERATURE TEXT NOT NULL, FORECAST TEXT NOT NULL, TIME TEXT, ISDAY BOOL NOT NULL)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<WeatherData> loadFromCache() async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> results = await database.rawQuery(
      'select * from weatherdata',
    );

    final Map<String, dynamic> json = results.first;

    return WeatherDataModel.fromJson({
      c.id: json['ID'],
      c.city: json['CITY'],
      c.temperature: jsonDecode(json['TEMPERATURE']),
      a.forecastDay: jsonDecode(json['FORECAST'])[a.forecastHour],
      c.isDay: json['ISDAY'] == 1,
      c.time: json['TIME'],
    });
  }

  @override
  Future<WeatherData> addToCache(
    WeatherData weatherData, {
    String table = 'WEATHERDATA',
  }) async {
    final Database database = await getDatabase();
    // await database.rawInsert(
    //   'INSERT INTO $table(ID, CITY ,TEMPERATURE, FORECAST,TIME, ISDAY) VALUES(${weatherData.id}, \'${weatherData.city}\',\'${jsonEncode(weatherData.temperature.toJson())}\',\'${jsonEncode(weatherData.hoursForecast.toJson())}\',\'${weatherData.time.toString()}\',${weatherData.isDay}) ON CONFLICT(ID) DO UPDATE',
    // );
    await database.insert(table, {
      'ID': weatherData.id,
      'CITY': weatherData.city,
      'TEMPERATURE': jsonEncode(weatherData.temperature.toJson()),
      'FORECAST': jsonEncode(weatherData.hoursForecast.toJson()),
      'TIME': weatherData.time.toString(),
      'ISDAY': weatherData.isDay ? 1 : 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    await database.close();

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('last-cache', DateTime.now().toString());

    return weatherData;
  }
}
