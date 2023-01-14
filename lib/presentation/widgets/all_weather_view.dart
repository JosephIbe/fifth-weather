import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:weather_stations/common/size_constants.dart';
import 'package:weather_stations/common/text_constants.dart';

import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/data/models/forecast_weather_model.dart';
import 'package:weather_stations/di/locator.dart' as locator;

import 'package:weather_stations/presentation/blocs/current_weather/current_weather_bloc.dart';
import 'package:weather_stations/presentation/blocs/forecast_weather/forecast_weather_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather_stations/presentation/widgets/forecasts_weather_view.dart';

class AllWeatherView extends StatefulWidget {
  const AllWeatherView({Key? key}) : super(key: key);

  @override
  State<AllWeatherView> createState() => _AllWeatherViewState();
}

class _AllWeatherViewState extends State<AllWeatherView> {

  late Size size;
  late Box box;

  @override
  void initState() {
    super.initState();

    box = Hive.box(TextConstants.weatherBox);

    context.read<CurrentWeatherBloc>()
        .add(GetCurrentWeather(
          latitude: box.get(TextConstants.latitude),
          longitude: box.get(TextConstants.longitude)
        ));

  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
            builder: (context, state){
              if(state is CurrentWeatherStateLoading){
                return const Center(child: CircularProgressIndicator(),);
              }
              if(state is CurrentWeatherStateSuccess){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Sizes.dimen_200,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${state.currentWeatherModel.main?.temp}\u00B0',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.dimen_40,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            state.currentWeatherModel.weather![0]!.description!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.dimen_35,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.dimen_20,
                          vertical: Sizes.dimen_10
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildTemperatureRangeText(
                              title: 'min',
                              value: state.currentWeatherModel.main?.tempMin
                          ),
                          buildTemperatureRangeText(
                              title: 'current',
                              value: state.currentWeatherModel.main?.temp
                          ),
                          buildTemperatureRangeText(
                              title: 'max',
                              value: state.currentWeatherModel.main?.tempMax
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white70, thickness: Sizes.dimen_2),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    '-- \u00B0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.dimen_40,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    'UNKNOWN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.dimen_35,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              );
            },
          ),
          BlocProvider<ForecastWeatherBloc>(
            create: (_) => ForecastWeatherBloc(weatherRepository: locator.locator()),
            child: const ForecastsWeatherView(),
          )
        ],
      ),
    );
  }

  Widget buildTemperatureRangeText({required String title, required double? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$value\u00B0',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ],
    );
  }

}