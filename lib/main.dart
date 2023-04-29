import 'package:flutter/material.dart';
import 'package:flutter_meteo/service/weather_service.dart';

void main() async {
  
  final WeatherService weatherService = WeatherService();

  final weatherDataParis = await weatherService.getTemperature('Paris');
  final weatherDataNewYork = await weatherService.getTemperature('New York');
  final weatherDataKinshasa = await weatherService.getTemperature('Kinshasa');
  final weatherDataSydney = await weatherService.getTemperature('Sydney');

  runApp(MyApp(
    weatherDataParis: weatherDataParis,
    weatherDataNewYork: weatherDataNewYork,
    weatherDataKinshasa: weatherDataKinshasa,
    weatherDataSydney: weatherDataSydney,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.weatherDataParis,
    required this.weatherDataNewYork,
    required this.weatherDataKinshasa,
    required this.weatherDataSydney,
    // super(key: key) appelle le constructeur de la classe parente StatelessWidget
  }) : super(key: key);

  final WeatherData weatherDataParis;
  final WeatherData weatherDataNewYork;
  final WeatherData weatherDataKinshasa;
  final WeatherData weatherDataSydney;

  Widget _cityCard(
    String city,
    double temperature,
    String localtime,
  ) {
    return Card( 
    color: Color.fromARGB(255, 215, 229, 219),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    side: BorderSide(color: Colors.grey, width: 4),
  ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Text(
            city,
            style: const TextStyle( 
              fontFamily: 'Carlito',
              fontSize: 36, 
              color:Color.fromARGB(255, 98, 17, 138)
              ),
          ),
          Text(
            '$temperature °C',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              ),
          ),
          Text(
            localtime,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Ma météo';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(14, 89, 110, 1),
          title: const Text(title),
          centerTitle: true,
        ),
        
        body: Container(
          color: const Color.fromRGBO(180, 189, 194, 1),
          child: Center(
            child: SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _cityCard(
                      weatherDataParis.city,
                      weatherDataParis.temperature,
                      weatherDataParis.localtime,
                    ),
                    _cityCard(
                      weatherDataNewYork.city,
                      weatherDataNewYork.temperature,
                      weatherDataNewYork.localtime,
                    ),
                   _cityCard(
                      weatherDataKinshasa.city,
                      weatherDataKinshasa.temperature,
                      weatherDataKinshasa.localtime,
                    ),
                    _cityCard(
                      weatherDataSydney.city,
                      weatherDataSydney.temperature,
                      weatherDataSydney.localtime,
                    ),
                  ],
                ),
              ),
            ),
            
          ),
        ),
        bottomNavigationBar: SizedBox(
        height: 120,
        child: Container(
        color: const Color.fromRGBO(14, 89, 110, 1),
      ),
        ),
      ),
    );
  }
}