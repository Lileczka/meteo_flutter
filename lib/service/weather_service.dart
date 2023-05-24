import 'package:dio/dio.dart';

import 'package:flutter_meteo/service/localisation_service.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';

//-----recuperer json depuis Api
class WeatherService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.weatherapi.com/v1/current.json';
  final List<String> cities = ['London', 'New York', 'Tokyo', 'Sydney'];

  Future<List<WeatherData>> fetchTemperatures() async {
    final List<WeatherData> temperatures = [];

    for (final city in cities) {
      final response = await _dio.get(_baseUrl, queryParameters: {
        'key': '37007acdb2ab4c029a5154256232804',
        'q': city,
        'localtime': 'true',
        'text': 'text',
      });

      final temperature = response.data['current']['temp_c'];
      final cityName = response.data['location']['name'];
      final localtime = response.data['location']['localtime'];
      final text = response.data['current']['condition']['text'];
      temperatures.add(WeatherData(
        temperature: temperature,
        city: cityName,
        localtime: localtime,
        text: text,
      ));
    }
    return temperatures;
  }

  Future<WeatherData> getCityName() async {
    final geoposition = await GeoLocalisation().getLocation();
    final response = await _dio.get(_baseUrl, queryParameters: {
      'key': '37007acdb2ab4c029a5154256232804',
      'q': geoposition,
      'localtime': 'true',
      'condition': 'text'
    });
    final temperature = response.data['current']['temp_c'];
    final cityName = response.data['location']['name'];
    final localtime = response.data['location']['localtime'];
    final text = response.data['current']['condition']['text'];
    print(localtime);

    // Formattage de la date
    final localDateTime = DateFormat('yyyy-MM-dd HH:mm').parse(localtime);
    final date = DateFormat('dd/MM/yyyy HH:mm').format(localDateTime);
    print(date);
/*
    //formater la date dd/MM/yyyy
    DateTime apiDate = DateTime.parse(localtime);
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    String formattedDate = dateFormat.format(apiDate);
*/
    var geoWeatherData = WeatherData(
      city: cityName,
      temperature: temperature,
      localtime: date,
      text: text,
    );

    //print(geoWeatherData.city);
    return geoWeatherData;
  }

  Future<WeatherData> getCityFromTextField(String cityName) async {
    //je dois récuperer valeur de Textefield et le mettre dans une variable cityName

    final response = await _dio.get(_baseUrl, queryParameters: {
      'key': '37007acdb2ab4c029a5154256232804',
      'q': cityName,
      'localtime': 'true',
      'condition': 'text'
    });
    final temperature = response.data['current']['temp_c'];
    final locationName = response.data['location']['name'];
    final localtime = response.data['location']['localtime'];
    final text = response.data['current']['condition']['text'];
    print('$locationName' '$localtime');

    // Formattage de la date
    final localDateTime = DateFormat('yyyy-MM-dd HH:mm').parse(localtime);
    final date = DateFormat('dd/MM/yyyy HH:mm').format(localDateTime);
    print(date);

    var geoWeatherData = WeatherData(
      city: locationName,
      temperature: temperature,
      localtime: date,
      text: text,
    );

    //print(geoWeatherData.city);
    return geoWeatherData;
  }
}
