import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:weather_stations/data/models/current_weather_model.dart';
import 'package:weather_stations/domain/entities/weather_request_params.dart';
import 'package:weather_stations/domain/usecases/current_weather_usecase.dart';

import 'package:weather_stations/presentation/blocs/current_weather/current_weather_bloc.dart';

import 'current_weather_bloc_test.mocks.dart';

@GenerateMocks([CurrentWeatherUseCase])
Future<void> main() async {
  const double latitude = 3.325;
  const double longitude = 6.4994;

  late CurrentWeatherModel currentWeatherModel;
  late MockCurrentWeatherUseCase currentWeatherUseCaseMock;
  late CurrentWeatherBloc currentWeatherBloc;

  setUp(() {
    currentWeatherModel = CurrentWeatherModel(
        coord: Coord(lat: latitude, lon: longitude),
        weather: [
          CurrentWeather(
              id: 721, description: "haze", icon: "50d", main: "Haze")
        ],
        base: "stations",
        main: Main(
            feelsLike: 31.02,
            humidity: 89,
            pressure: 1014,
            temp: 27.14,
            tempMax: 27.14,
            tempMin: 27.14),
        visibility: 2500,
        wind: Wind(deg: 310, speed: 2.06),
        clouds: Clouds(all: 40),
        dt: 1673688080,
        sys: Sys(
            id: 1,
            country: "Nigeria",
            sunrise: 1673676120,
            sunset: 1673718526,
            type: 1185),
        timezone: 3600,
        id: 2566677,
        name: "I love tests",
        cod: 200);
    currentWeatherUseCaseMock = MockCurrentWeatherUseCase();
    currentWeatherBloc =
        CurrentWeatherBloc(currentWeatherUseCase: currentWeatherUseCaseMock);
  });

  group('current weather', () {

    test('current weather initial state should be [CurrentWeatherStateInitial]',
        () {
      expect(currentWeatherBloc.state.runtimeType, CurrentWeatherStateInitial);
    });

    blocTest('Check if Current Weather is Fetched',
        build: () => currentWeatherBloc,
        act: (CurrentWeatherBloc bloc) {
          when(currentWeatherUseCaseMock.call(const WeatherRequestParams(
                  latitude: latitude, longitude: longitude)))
              .thenAnswer((_) async => currentWeatherModel);
          bloc.add(const GetCurrentWeather(
              latitude: latitude, longitude: longitude));
        },
        expect: () => [
              isA<CurrentWeatherStateLoading>(),
              isA<CurrentWeatherStateSuccess>(),
            ],
        verify: (CurrentWeatherBloc bloc) {
          verify(currentWeatherUseCaseMock.call(any)).called(1);
        });
  });

  tearDown(() {
    currentWeatherBloc.close();
  });

}