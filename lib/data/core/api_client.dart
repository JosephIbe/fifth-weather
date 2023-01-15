import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:weather_stations/data/core/api_constants.dart';

class APIClient {

  APIClient();

  Future getCurrentWeather({required double latitude, required double longitude}) async {

    try {
      var url = '${APIConstants.baseURL}${APIConstants.currentWeather}?lat=$latitude&lon=$longitude&units=metric&appid=06a865cf803b1412f95d3465d49ae0e4';
      log('current url:\n$url');
      http.Response response = await http.get(Uri.parse(url), );
      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      }

    } on Exception catch(e) {
      log(e.toString());
    }

  }

  Future getForecast({required double latitude, required double longitude}) async {

    try {
      var url = '${APIConstants.baseURL}/${APIConstants.fiveDaysForecast}?lat=$latitude&lon=$longitude&appid=06a865cf803b1412f95d3465d49ae0e4&units=metric';
      log('forecast url:\n$url');
      http.Response response = await http.get(Uri.parse(url), );
      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      }

    } on Exception catch(e) {
      log(e.toString());
    }

  }

}