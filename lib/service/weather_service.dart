import 'package:dio/dio.dart';
import 'dart:convert';

class WeatherData {
  final double temperature;
  final String city;
  final String localtime;

  WeatherData(
      {required this.temperature, required this.city, required this.localtime});
}

class WeatherService {
  final dio = Dio();

  final String _baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<WeatherData> getTemperature(String city) async {
    final param = {
      'key': '37007acdb2ab4c029a5154256232804',
      'q': city, 
      'localtime': 'true',
    };

    final response = await dio.get(
      _baseUrl,
      queryParameters: param,
    );

    // Récupération de la température en Celsius depuis la réponse HTTP
    final temperature = response.data['current']['temp_c'];
    // Récupération de la ville
    final cityResult = response.data['location']['name'];
    // Récupération de la date
    final localtime = response.data['location']['localtime'];
    print('Temperature: $temperature, $cityResult, $localtime');

    final weatherData =
        WeatherData(temperature: temperature, city: cityResult, localtime: localtime);
    return weatherData;
  }

  Future<List<WeatherData>> getTemperaturesForCities(List<String> cities) async {
    final List<WeatherData> temperatures = [];

    // Parcourir la liste de villes pour récupérer les températures de chaque ville
    for (final city in cities) {
      final temperature = await getTemperature(city);
      temperatures.add(temperature);
    }

    // Affichage des températures de chaque ville récupérée
    for (final temperature in temperatures) {
      
      print('${temperature.city}: ${temperature.temperature}°C');
    }

    return temperatures;
  }
}
















  
  
  
  
  