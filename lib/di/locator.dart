import 'package:get_it/get_it.dart';
import 'package:weather_stations/data/core/api_client.dart';
import 'package:weather_stations/data/data_sources/location_data_source.dart';

import 'package:weather_stations/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_stations/data/repositories/location_repository_impl.dart';
import 'package:weather_stations/data/repositories/weather_repository_impl.dart';
import 'package:weather_stations/domain/location_repository.dart';
import 'package:weather_stations/domain/weather_repository.dart';
import 'package:weather_stations/presentation/blocs/location/location_bloc.dart';
import 'package:weather_stations/presentation/blocs/current_weather/current_weather_bloc.dart';

final locator = GetIt.I;

Future init() async {

  locator.registerLazySingleton<APIClient>(() => APIClient());

  locator.registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl());
  locator.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(dataSource: locator()));
  locator.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(dataSource: locator()));

  locator.registerFactory(() => LocationBloc(locationRepository: locator()));
  locator.registerFactory(() => CurrentWeatherBloc(weatherRepository: locator()));

}