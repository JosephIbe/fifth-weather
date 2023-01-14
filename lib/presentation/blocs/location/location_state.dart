part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationStateInitial extends LocationState {}

class LocationStateLoading extends LocationState {}

class LocationStateSuccess extends LocationState {
  final Position position;

  const LocationStateSuccess({
    required this.position,
  });

  @override
  List<Object?> get props => [position];
}

class LocationStateFailure extends LocationState {
  final String errorMessage;
  const LocationStateFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
