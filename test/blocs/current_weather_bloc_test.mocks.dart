// Mocks generated by Mockito 5.3.2 from annotations
// in weather_stations/test/blocs/current_weather_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_stations/data/models/current_weather_model.dart' as _i3;
import 'package:weather_stations/domain/entities/weather_request_params.dart'
    as _i6;
import 'package:weather_stations/domain/repositories/weather_repository.dart'
    as _i2;
import 'package:weather_stations/domain/usecases/current_weather_usecase.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWeatherRepository_0 extends _i1.SmartFake
    implements _i2.WeatherRepository {
  _FakeWeatherRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCurrentWeatherModel_1 extends _i1.SmartFake
    implements _i3.CurrentWeatherModel {
  _FakeCurrentWeatherModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CurrentWeatherUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrentWeatherUseCase extends _i1.Mock
    implements _i4.CurrentWeatherUseCase {
  MockCurrentWeatherUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WeatherRepository get weatherRepository => (super.noSuchMethod(
        Invocation.getter(#weatherRepository),
        returnValue: _FakeWeatherRepository_0(
          this,
          Invocation.getter(#weatherRepository),
        ),
      ) as _i2.WeatherRepository);
  @override
  _i5.Future<_i3.CurrentWeatherModel> call(_i6.WeatherRequestParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.CurrentWeatherModel>.value(
            _FakeCurrentWeatherModel_1(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.CurrentWeatherModel>);
}
