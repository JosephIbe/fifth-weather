import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';

import 'package:weather_stations/common/text_constants.dart';

import 'package:weather_stations/di/locator.dart' as locator;
import 'package:weather_stations/domain/entities/no_params.dart';

import 'package:weather_stations/domain/usecases/location_usecase.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  final LocationUseCase _locationUseCase;

  LocationBloc({required LocationUseCase locationUseCase})
      : assert(locationUseCase != null),
        _locationUseCase = locationUseCase,
        super(LocationStateInitial())
  {
    on<GetUserLocation>(_loadLocation);
  }

  void _loadLocation(GetUserLocation event, Emitter<LocationState> emit) async {

    final locationData = await _locationUseCase(NoParams());

    if(locationData.longitude.toString().isNotEmpty && locationData.latitude.toString().isNotEmpty) {

      final box = Hive.box(TextConstants.weatherBox);

      box.put(TextConstants.latitude, locationData.latitude);
      box.put(TextConstants.longitude, locationData.longitude);

      emit(LocationStateSuccess(
        position: locationData,
      ));
    }

  }

}