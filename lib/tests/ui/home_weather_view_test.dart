import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_stations/di/locator.dart' as locator;
import 'package:weather_stations/presentation/blocs/location/location_bloc.dart';
import 'package:weather_stations/presentation/journeys/home_weather_view.dart';

class MockLocationBloc extends Mock implements LocationBloc {}

main(){

  late Widget app;
  late LocationBloc _locationBloc;

  setUp((){

    _locationBloc = LocationBloc(locationRepository: locator.locator());

    app = MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>.value(value: _locationBloc)
      ],
      child: const MaterialApp(
        home: HomeWeatherView(),
      ),
    );
  });

  tearDown((){
    _locationBloc.close();
  });

  testWidgets('should get user location', (widgetTester) async {
    await widgetTester.pumpWidget(app);
    await widgetTester.pumpAndSettle();

    expect(find., matcher)

  });

}