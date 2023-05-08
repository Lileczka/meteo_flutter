import 'package:flutter/material.dart';
import 'package:flutter_meteo/pages/home_page.dart';

void main() async {
  //méthode pour s'assuer que l'application est initialisée correctement avant son exécution
  //et garantir une expérience utilisateur fluide.

  WidgetsFlutterBinding.ensureInitialized();

  // final weatherService = WeatherService();
  // final temperatures = await weatherService.fetchTemperatures();

  // print('Les températures pour les villes suivantes ont été récupérées:');
  // for (final temperature in temperatures) {
  //   print('${temperature.city}: ${temperature.temperature}°C (${temperature.localtime})');
  // }

  runApp(const HomePage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
