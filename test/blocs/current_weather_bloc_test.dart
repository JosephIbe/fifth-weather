// import 'dart:io';
//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:bloc_test/bloc_test.dart';
//
// import 'package:weather_stations/data/core/api_client.dart';
// import 'package:weather_stations/data/data_sources/weather_remote_data_source.dart';
// import 'package:weather_stations/data/models/current_weather_model.dart';
// import 'package:weather_stations/data/repositories/weather_repository_impl.dart';
//
// import 'package:weather_stations/domain/repositories/weather_repository.dart';
// import 'package:weather_stations/presentation/blocs/current_weather/current_weather_bloc.dart';
// import 'package:weather_stations/di/locator.dart' as locator;
//
// class MockAPIClient extends Mock implements APIClient {}
// class MockWeatherRemoteDataSource extends Mock implements WeatherRemoteDataSource {}
// class MockWeatherRepositoryImpl extends Mock implements WeatherRepositoryImpl {}
//
// void main() {
//
//   group('current weather', () {
//
//     late MockAPIClient mockAPIClient;
//
//     late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
//     late MockWeatherRepositoryImpl mockWeatherRepository;
//
//     const double latitude = 3.325;
//     const double longitude = 6.4994;
//
//     final CurrentWeatherModel currentWeatherModel = CurrentWeatherModel(
//         coord: Coord(lat: latitude, lon: longitude),
//         weather: [Weather(id: 721, description: "haze", icon: "50d", main: "Haze")],
//         base: "stations",
//         main: Main(feelsLike: 31.02, humidity: 89, pressure: 1014, temp: 27.14, tempMax: 27.14, tempMin: 27.14),
//         visibility: 2500,
//         wind: Wind(deg: 310, speed: 2.06),
//         clouds: Clouds(all: 40),
//         dt: 1673688080,
//         sys: Sys(id: 1, country: "Nigeria", sunrise: 1673676120, sunset: 1673718526, type: 1185),
//         timezone: 3600,
//         id: 2566677,
//         name: "I hate tests",
//         cod: 200
//     );
//
//     late WeatherRepositoryImpl weatherRepository;
//     late WeatherRemoteDataSourceImpl weatherRemoteDataSource;
//
//     late CurrentWeatherBloc currentWeatherBloc;
//
//     setUp((){
//       mockAPIClient = MockAPIClient();
//       mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
//       mockWeatherRepository = MockWeatherRepositoryImpl();
//
//       weatherRemoteDataSource = WeatherRemoteDataSourceImpl(client: mockAPIClient);
//       weatherRepository = WeatherRepositoryImpl(dataSource: mockWeatherRemoteDataSource);
//
//       currentWeatherBloc = CurrentWeatherBloc(weatherRepository: mockWeatherRepository);
//     });
//
//     void arrangeCurrentWeatherResponse() {
//       when(()=> mockWeatherRepository.getCurrentWeatherAtGeoPoint(latitude: latitude, longitude: longitude));
//     }
//
//     blocTest<CurrentWeatherBloc, CurrentWeatherState>(
//       'Current Weather Bloc Test',
//       build: () => CurrentWeatherBloc(weatherRepository: locator.locator()),
//       act: (bloc) {
//         currentWeatherBloc.add(const GetCurrentWeather(latitude: latitude, longitude: longitude));
//       },
//       expect: () => <CurrentWeatherState>[
//         CurrentWeatherStateLoading(),
//         CurrentWeatherStateSuccess(currentWeatherModel: currentWeatherModel)
//       ],
//     );
//
//     tearDown((){
//       currentWeatherBloc.close();
//     });
//
//   });
//
// }