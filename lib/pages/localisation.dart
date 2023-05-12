import 'package:flutter/material.dart';
import 'package:flutter_meteo/models/weather_model.dart';
import 'package:flutter_meteo/service/weather_service.dart';
import 'package:flutter_meteo/view/geo_weather_card.dart';

class Localisation extends StatefulWidget {
  const Localisation({super.key});

  @override
  State<Localisation> createState() => _Localisation();
}

class _Localisation extends State<Localisation> {
  late Future<List<WeatherData>> weatherdata;
  @override
  void initState() {
    weatherdata = WeatherService().fetchTemperatures();
    super.initState();
    getCityName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 41, 125),
        title: const Text('Ma météo du jour 🌤️'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sky.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              FutureBuilder<List<WeatherData>>(
                future: weatherdata,
                builder: (context, snapshot) {
                  return GeoWidget(
                    snapshot.data?[0].city ?? '',
                    snapshot.data?[0].temperature ?? 0.0,
                    snapshot.data?[0].localtime ?? '',
                  );
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        onPressed: () async {
                          //Get the current location
                          //var geoloc = await getLocation();
                          //getLocation();
                        },
                        icon: const Icon(Icons.near_me, size: 50),
                        color: const Color.fromARGB(255, 226, 147, 29),
                      ),
                      IconButton(
                        onPressed: () {
                          //print('clik');
                          //Navigator.pushNamed(context, '/');
                        },
                        icon: const Icon(Icons.location_city, size: 50),
                        color: const Color.fromARGB(255, 226, 147, 29),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
