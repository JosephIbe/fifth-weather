import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_stations/di/locator.dart' as locator;
import 'package:weather_stations/presentation/blocs/current_weather/current_weather_bloc.dart';
import 'package:weather_stations/presentation/widgets/all_weather_view.dart';

class WeatherOverview extends StatelessWidget {

  const WeatherOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentWeatherBloc>(
      create: (_) => CurrentWeatherBloc(weatherRepository: locator.locator()),
      child: const AllWeatherView(),
    );
  }

}