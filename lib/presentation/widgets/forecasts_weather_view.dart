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
    return ListTile(
      // leading: Text(getDayOfWeekFromUTCDate(foreCastItem.dt)),
      leading: Text('today nau'),
      title: Icon(Icons.cloud),
      trailing: Text('${foreCastItem.temp!.max}\u00B0'),
    );
  }

  String getDayOfWeekFromUTCDate(int? dt) {
    print('utc dt:\t$dt');

    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dt.toString(), true);
    print('dateTime:\t$dateTime');
    var dateLocal = dateTime.toLocal();
    print('local dateTime:\t$dateLocal');

    print('day of week string:\t${DateFormat('EEEE').format(dateLocal)}');
    return 'Today haha';
  }

}