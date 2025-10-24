import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather/models/weather_data.dart';

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

    return WeatherDataModel.fromJson(results.first);
  }

  @override
  Future<WeatherData> addToCache(
    WeatherData weatherData, {
    String table = 'WEATHERDATA',
  }) async {
    final Database database = await getDatabase();
    await database.rawInsert(
      'INSERT INTO $table(ID, CITY ,TEMPERATURE, FORECAST,TIME, ISDAY) VALUES(${weatherData.id}, \'${weatherData.city}\',\'${weatherData.temperature.toJson().toSqliteString()}\',\'${weatherData.hoursForecast.toJson().toSqliteString()}\',\'${weatherData.time.toString()}\',\'${weatherData.isDay}\')',
    );
    await database.close();

    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('last-cache', DateTime.now().toString());

    return weatherData;
  }
}

extension StringMap on Map<String, dynamic> {
  String toSqliteString() {
    StringBuffer st = StringBuffer();
    st.write('{');

    int i = 0;
    for (final MapEntry entry in entries) {
      final String key = entry.key;
      final dynamic value = entry.value;
      final String stringR = '"$key": "$value"';
      st.write(stringR);
      if (i < entries.length - 1) {
        st.write(',');
      }
      i++;
    }
    st.write('}');
    return st.toString();
  }
}
