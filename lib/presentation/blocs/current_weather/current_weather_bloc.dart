import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/domain/entities/weather_request_params.dart';
import 'package:weather_stations/domain/repositories/weather_repository.dart';
import 'package:weather_stations/domain/usecases/current_weather_usecase.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<WeatherEvent, CurrentWeatherState> {

  final CurrentWeatherUseCase _currentWeatherUseCase;

  CurrentWeatherBloc({required CurrentWeatherUseCase currentWeatherUseCase})
      : _currentWeatherUseCase = currentWeatherUseCase,
      super(CurrentWeatherStateInitial()) {
    on<GetCurrentWeather>(_getCurrentWeather);
  }

  void _getCurrentWeather(GetCurrentWeather event, Emitter<CurrentWeatherState> emit) async {
    emit(CurrentWeatherStateLoading());
    final data = await _currentWeatherUseCase(WeatherRequestParams(latitude: event.latitude, longitude: event.longitude));
    print('data in bloc:\n$data');
    emit(CurrentWeatherStateSuccess(currentWeatherModel: data));
  }

}