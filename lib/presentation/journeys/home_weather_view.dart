import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:weather_stations/common/size_constants.dart';
import 'package:weather_stations/common/text_constants.dart';

import 'package:weather_stations/di/locator.dart' as locator;

import 'package:weather_stations/presentation/blocs/location/location_bloc.dart';
import 'package:weather_stations/presentation/widgets/weather_overview.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWeatherView extends StatefulWidget {
  const HomeWeatherView({Key? key}) : super(key: key);

  @override
  State<HomeWeatherView> createState() => _HomeWeatherViewState();
}

class _HomeWeatherViewState extends State<HomeWeatherView> {

  late Size size;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: BlocListener<LocationBloc, LocationState>(
          listener: (context, state){
            if(state is LocationStateFailure){
              ///todo show a message to user
              log('Could Not Determine Your Location');
            }
          },
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state){
              if(state is LocationStateFailure){
                return Container(
                  width: size.width,
                  height: size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Image.asset('assets/error.gif'),
                      const SizedBox(height: Sizes.dimen_20,),

                      const Text(
                        TextConstants.failedToGetLocation,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w400,
                          fontSize: Sizes.dimen_35
                        ),
                      )
                    ],
                  ),
                );
              }
              if(state is LocationStateSuccess){
                return WeatherOverview(currentWeatherUseCase: locator.locator(),);
              }
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                child: Center(
                  child: Image.asset('assets/location_loading.gif'),
                ),
              );
            },
          ),
        )
      ),
    );
  }

}