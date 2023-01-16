import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:weather_stations/common/text_constants.dart';
import 'package:weather_stations/data/models/forecast_weather_model.dart';
import 'package:weather_stations/presentation/blocs/forecast_weather/forecast_weather_bloc.dart';

class ForecastsWeatherView extends StatefulWidget {
  const ForecastsWeatherView({Key? key}) : super(key: key);

  @override
  State<ForecastsWeatherView> createState() => _ForecastsWeatherViewState();
}

class _ForecastsWeatherViewState extends State<ForecastsWeatherView> {

  late Box box;

  @override
  void initState() {
    super.initState();

    box = Hive.box(TextConstants.weatherBox);

    context.read<ForecastWeatherBloc>()
        .add(GetWeatherForecast(
        latitude: box.get(TextConstants.latitude),
        longitude: box.get(TextConstants.longitude)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
        builder: (context, state){
          if(state is ForecastWeatherStateLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is ForecastWeatherStateSuccess){
            return ListView.builder(
              itemCount: state.forecastWeatherModel.list?.length,
              itemBuilder: (context, index){
                ForecastDayItem item = state.forecastWeatherModel.list![index]!;
                return buildForeCastDay(foreCastItem: item);
              },
            );
          }
          return const ListTile(
            leading: Text('--'),
            title: Icon(Icons.cloud_off),
            trailing: Text('--'),
          );
        },
      ),
    );
  }

  Widget buildForeCastDay({required ForecastDayItem foreCastItem}) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(getDayOfWeekFromUTCDate(foreCastItem.dt))),
          const Expanded(flex: 2, child: Icon(Icons.cloud)),
          Expanded(flex: 1, child: Padding(
            padding: const EdgeInsets.fromLTRB(38.0, 0, 0, 10),
            child: Text('${foreCastItem.temp!.max}\u00B0'),
          )),
        ],
      ),
    );
  }

  String getDayOfWeekFromUTCDate(int? dt) {
    final serverDate = DateTime.fromMillisecondsSinceEpoch(dt! * 1000, isUtc: true);
    // String dateString = "${serverDate.year}/${serverDate.month}/${serverDate.day}";
    // print('date String:\t$dateString');

    // String d = DateFormat('yyy-MMM-dd').format(serverDate);
    // print('d:\t$d');
    // print(DateFormat('EEEE').format(serverDate));

    return DateFormat('EEEE').format(serverDate);
  }

}