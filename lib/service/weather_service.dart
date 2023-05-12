import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:geocoding/geocoding.dart';

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
      });

      final temperature = response.data['current']['temp_c'];
      final cityName = response.data['location']['name'];
      final localtime = response.data['location']['localtime'];
      temperatures.add(WeatherData(
        temperature: temperature,
        city: cityName,
        localtime: localtime,
      ));
    }
    return temperatures;
  }
}

List<Placemark> place = [];

void getCityName() async {
  try {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks != null && placemarks.isNotEmpty) {
      final Placemark placemark = placemarks[0];
      final cityName = placemark.locality;
      print(cityName);
    }
  } catch (e) {
    print(e.toString());
  }
}
