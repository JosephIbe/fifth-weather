// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'package:geolocator/geolocator.dart' show Position;
// import 'package:weather_stations/domain/usecases/location_usecase.dart';
//
// import 'package:weather_stations/presentation/blocs/current_weather/current_weather_bloc.dart';
// import 'package:weather_stations/presentation/blocs/location/location_bloc.dart';
//
// import 'location_bloc_test.mocks.dart';
//
// @GenerateMocks([LocationUseCase])
// Future<void> main() async {
//   const double latitude = 3.325;
//   const double longitude = 6.4994;
//
//   late Position position;
//   late MockLocationUseCase locationUseCaseMock;
//   late LocationBloc locationBloc;
//
//   setUp(() {
//     position = Position(
//         longitude: longitude,
//         latitude: latitude,
//         timestamp: DateTime.now(),
//         accuracy: 99.9,
//         altitude: 0.0,
//         heading: 0.0,
//         speed: 36.7,
//         speedAccuracy: 0.5
//     );
//     locationUseCaseMock = MockLocationUseCase();
//     locationBloc = LocationBloc(locationUseCase: locationUseCaseMock);
//   });
//
//   group('current location', () {
//
//     test('location initial state should be [LocationStateInitial]',
//             () {
//           expect(locationBloc.state.runtimeType, LocationStateInitial);
//         });
//
//     blocTest('Check if Location is Fetched',
//         build: () => locationBloc,
//         act: (LocationBloc bloc) {
//           when(locationUseCaseMock.call(any))
//               .thenAnswer((_) async => position);
//           bloc.add(GetUserLocation());
//         },
//         expect: () => [
//           isA<LocationStateLoading>(),
//           isA<LocationStateSuccess>(),
//         ],
//         verify: (LocationBloc bloc) {
//           verify(locationUseCaseMock.call(any)).called(1);
//         });
//   });
//
//   tearDown(() {
//     locationBloc.close();
//   });
//
// }