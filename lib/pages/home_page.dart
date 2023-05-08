import 'package:flutter/material.dart';
import 'package:flutter_meteo/models/weather_model.dart';
import 'package:flutter_meteo/service/weather_service.dart';
import 'package:flutter_meteo/view/weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late Future<List<WeatherData>> weatherdata;

  @override
  void initState() {
    weatherdata = WeatherService().fetchTemperatures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 13, 41, 125),
          title: const Text('Ma météo du jour  🌤️'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/cloud.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FutureBuilder<List<WeatherData>>(
                  future: weatherdata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        crossAxisCount: 2,
                        children: [
                          for (var i = 0; i < snapshot.data!.length; i++)
                            MyWidget(
                              snapshot.data?[i].city ?? '',
                              snapshot.data?[i].temperature ?? 0.0,
                              snapshot.data?[i].localtime ?? '',
                            ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Erreur: ${snapshot.error}"),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          color: const Color.fromARGB(255, 13, 41, 125),
        ),
      ),
    );
  }
}
