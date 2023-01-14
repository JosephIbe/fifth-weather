import 'package:flutter/material.dart';

import 'package:weather_stations/common/text_constants.dart';

import 'package:weather_stations/data/repositories/location_repository_impl.dart';
import 'package:weather_stations/data/repositories/weather_repository_impl.dart';

import 'package:weather_stations/di/locator.dart' as locator;

import 'package:weather_stations/domain/location_repository.dart';
import 'package:weather_stations/domain/weather_repository.dart';

import 'package:weather_stations/presentation/blocs/location/location_bloc.dart';
import 'package:weather_stations/presentation/journeys/home_weather_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedantic/pedantic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(locator.init());

  final path = await getApplicationDocumentsDirectory();
  Hive.init(path.path);

  await Hive.openBox(
    TextConstants.weatherBox,
  );

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<WeatherRepository>(create: (_) => WeatherRepositoryImpl(dataSource: locator.locator())),
      RepositoryProvider<LocationRepository>(create: (_) => LocationRepositoryImpl(dataSource: locator.locator()))
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (context){
            final repo = context.read<LocationRepository>();
            return LocationBloc(locationRepository: repo)..add(GetUserLocation());
          },
        ),
      ],
      child: const WeatherApp(),
    ),
  ));
}

class WeatherApp extends StatelessWidget {

  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'WeatherYou',
      home: HomeWeatherView(),
    );
  }
}