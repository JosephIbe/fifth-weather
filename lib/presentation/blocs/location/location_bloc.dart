import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:weather_stations/common/text_constants.dart';
import 'package:weather_stations/domain/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  final LocationRepository _repository;

  LocationBloc({required LocationRepository locationRepository})
      : assert(locationRepository != null),
        _repository = locationRepository,
        super(LocationStateInitial())
  {
    on<GetUserLocation>(_loadLocation);
  }

  void _loadLocation(GetUserLocation event, Emitter<LocationState> emit) async {

    final locationData = await _repository.getCurrentLocation();

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