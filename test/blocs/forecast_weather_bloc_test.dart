import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:weather_stations/data/models/forecast_weather_model.dart';
import 'package:weather_stations/domain/entities/weather_request_params.dart';

import 'package:weather_stations/domain/usecases/forecast_weather_usecase.dart';
import 'package:weather_stations/presentation/blocs/forecast_weather/forecast_weather_bloc.dart';

import 'forecast_weather_bloc_test.mocks.dart';

@GenerateMocks([ForecastWeatherUseCase])
Future<void> main() async {

  const double latitude = 3.325;
  const double longitude = 6.4994;

  late ForecastWeatherModel forecastWeatherModel;

  late MockForecastWeatherUseCase forecastWeatherUseCaseMock;
  late ForecastWeatherBloc forecastWeatherBloc;

  setUp((){
    forecastWeatherModel = ForecastWeatherModel(
        city: City(
          country: "NG",
          id: 2566677,
          name: "Abuja",
          coords: Coords(lon: longitude, lat: latitude),
          population: 0,
          timezone: 3600,
        ),
        cnt: 1,
        cod: "200",
        message: 12.194429,
        list: [
          ForecastDayItem(
              dt: 1673521200,
              sunrise: 1673503285,
              sunset: 1673545670,
              temp: Temp(
                  day: 28.75,
                  eve: 25.78,
                  max: 30.98,
                  min: 27.79,
                  morn: 29.49,
                  night: 12.09
              ),
              feelsLike: FeelsLike(
                  night: 29.91,
                  morn: 26.32,
                  eve: 31.22,
                  day: 32.19
              ),
              pressure: 1013,
              humidity: 70,
              speed: 6.56,
              deg: 184,
              clouds: 22,
              gust: 5.87,
              pop: 0,
              weather: [
                ForecastWeather(id: 801, main: "Clouds", description: "few clouds", icon: "02d")
              ]
          ),
        ]
    );
    forecastWeatherUseCaseMock = MockForecastWeatherUseCase();
    forecastWeatherBloc = ForecastWeatherBloc(forecastWeatherUseCase: forecastWeatherUseCaseMock);
  });

  group('forecast weather', () {

    test('forecast weather initial state should be [ForecastWeatherStateInitial]', (){
      expect(forecastWeatherBloc.state.runtimeType, ForecastWeatherStateInitial);
    });

    blocTest(
        'Check if Forecast Weather is Fetched',
        build: ()=> forecastWeatherBloc,
        act: (ForecastWeatherBloc bloc){
          when(forecastWeatherUseCaseMock.call(
              const WeatherRequestParams(latitude: latitude, longitude: longitude)
          )).thenAnswer((_) async => forecastWeatherModel);

          bloc.add(const GetWeatherForecast(latitude: latitude, longitude: longitude));
        },
        expect: ()=> [isA<ForecastWeatherStateLoading>(), isA<ForecastWeatherStateSuccess>()],
        verify: (ForecastWeatherBloc bloc) {
          verify(forecastWeatherUseCaseMock.call(any)).called(1);
        });

    tearDown(() {
      forecastWeatherBloc.close();
    });
  });

}