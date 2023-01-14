part of 'current_weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];

}

class GetCurrentWeather extends WeatherEvent {
  final double latitude;
  final double longitude;
  const GetCurrentWeather({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
