/*
  Class for provider state
*/

sealed class AppState<T> {}

class DataState<T> implements AppState<T> {
  final T weatherData;
  const DataState({required this.weatherData});
}

class ErrorState<T> implements AppState<T> {}

class LoadingState<T> implements AppState<T> {}
