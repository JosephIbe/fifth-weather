import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_stations/data/models/forecast_weather_model.dart';
import 'package:weather_stations/domain/entities/weather_request_params.dart';
import 'package:weather_stations/domain/usecases/forecast_weather_usecase.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {

  final ForecastWeatherUseCase _forecastWeatherUseCase;

  ForecastWeatherBloc({required ForecastWeatherUseCase forecastWeatherUseCase})
      : _forecastWeatherUseCase = forecastWeatherUseCase,
        super(ForecastWeatherStateInitial()) {
    on<GetWeatherForecast>(_getWeatherForecast);
  }

  void _getWeatherForecast(GetWeatherForecast event, Emitter<ForecastWeatherState> emit) async {
    emit(ForecastWeatherStateLoading());
    final data = await _forecastWeatherUseCase(WeatherRequestParams(latitude: event.latitude, longitude: event.longitude));
    emit(ForecastWeatherStateSuccess(forecastWeatherModel: data));
  }

}