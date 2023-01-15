import 'package:flutter/material.dart';

import 'package:weather_stations/domain/usecases/current_weather_usecase.dart';

import 'package:weather_stations/presentation/blocs/current_weather/current_weather_bloc.dart';

import 'package:weather_stations/presentation/widgets/all_weather_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherOverview extends StatelessWidget {

  final CurrentWeatherUseCase currentWeatherUseCase;
  const WeatherOverview({
    Key? key,
    required this.currentWeatherUseCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentWeatherBloc>(
      create: (_) => CurrentWeatherBloc(currentWeatherUseCase: currentWeatherUseCase),
      child: const AllWeatherView(),
    );
  }

}