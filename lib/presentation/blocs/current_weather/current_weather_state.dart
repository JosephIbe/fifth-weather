part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];

}

class CurrentWeatherStateInitial extends CurrentWeatherState {}

class CurrentWeatherStateLoading extends CurrentWeatherState {}

class CurrentWeatherStateSuccess extends CurrentWeatherState {

  final CurrentWeatherModel currentWeatherModel;
  const CurrentWeatherStateSuccess({required this.currentWeatherModel});

  @override
  List<Object> get props => [currentWeatherModel];

}

class CurrentWeatherStateFailure extends CurrentWeatherState {

  final String reasonPhrase;
  const CurrentWeatherStateFailure({required this.reasonPhrase});

  @override
  List<Object> get props => [reasonPhrase];

}