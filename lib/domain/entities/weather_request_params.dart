import 'package:equatable/equatable.dart';

class WeatherRequestParams extends Equatable {
  final double latitude;
  final double longitude;

  const WeatherRequestParams({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [];

}