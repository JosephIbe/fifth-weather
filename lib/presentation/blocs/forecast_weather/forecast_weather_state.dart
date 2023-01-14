part of 'forecast_weather_bloc.dart';

abstract class ForecastWeatherState extends Equatable {
  const ForecastWeatherState();

  @override
  List<Object?> get props => [];

}

class ForecastWeatherStateInitial extends ForecastWeatherState {}

class ForecastWeatherStateLoading extends ForecastWeatherState {}

class ForecastWeatherStateSuccess extends ForecastWeatherState {

  final ForecastWeatherModel forecastWeatherModel;
  const ForecastWeatherStateSuccess({required this.forecastWeatherModel});

  @override
  List<Object> get props => [forecastWeatherModel];

}

class ForecastWeatherStateFailure extends ForecastWeatherState {

  final String reasonPhrase;
  const ForecastWeatherStateFailure({required this.reasonPhrase});

  @override
  List<Object> get props => [reasonPhrase];

}