import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/data/models/forecast_weather_model.dart';
import 'package:weather_stations/domain/weather_repository.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<WeatherEvent, CurrentWeatherState> {

  final WeatherRepository _weatherRepository;

  CurrentWeatherBloc({required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
      super(CurrentWeatherStateInitial()) {
    on<GetCurrentWeather>(_getCurrentWeather);
  }

  void _getCurrentWeather(GetCurrentWeather event, Emitter<CurrentWeatherState> emit) async {
    emit(CurrentWeatherStateLoading());
    final data = await _weatherRepository
        .getCurrentWeatherAtGeoPoint(latitude: event.latitude, longitude: event.longitude);
    print('getCurrentWeather data:\n$data');
    emit(CurrentWeatherStateSuccess(currentWeatherModel: data));
  }

}
