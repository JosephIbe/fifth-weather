part of 'forecast_weather_bloc.dart';

abstract class ForecastWeatherEvent extends Equatable {
  const ForecastWeatherEvent();

  @override
  List<Object?> get props => [];

}

class GetUserLocation extends ForecastWeatherEvent {}

class GetWeatherForecast extends ForecastWeatherEvent {
  final double latitude;
  final double longitude;
  const GetWeatherForecast({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
