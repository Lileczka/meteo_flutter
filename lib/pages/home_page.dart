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

  String cityName = '';
  //variable pour la condition pour mettre placeholder en rouge
  bool isCityNameEmpty = false;

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
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    //button pour afficher geolocalisation
                    child: IconButton(
                      onPressed: () async {
                        /* final cityFromGeolocalisation =
                            WeatherService().getCityName();
          */
                        Navigator.pushNamed(
                          context, '/localisation',
                          // arguments: cityFromGeolocalisation
                        );
                      },
                      icon: const Icon(Icons.arrow_circle_left, size: 50),
                      alignment: Alignment.centerLeft,
                      color: const Color.fromARGB(255, 13, 41, 125),
                      padding: const EdgeInsets.only(left: 20, top: 10),
                    ),
                  ),
                  Expanded(
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
            ],
          ),
        ),
        bottomNavigationBar: Stack(
          children: [
            Container(
              height: 210,
              color: const Color.fromARGB(255, 13, 41, 125),
            ),
            Positioned(
              left: 50,
              right: 50,
              bottom: 50,
              // button qui envoye la valeur ville vers la page localisation
              child: ElevatedButton(
                onPressed: () {
                  //avec la condition si le champ est vide afficher placeholder en rouge
                  if (cityName.isNotEmpty) {
                    Navigator.pushNamed(context, '/localisation',
                        arguments: cityName);
                  } else {
                    setState(() {
                      isCityNameEmpty = true;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 13, 41, 125),
                  foregroundColor: const Color.fromARGB(255, 13, 41, 125),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
                child: const Text(
                  'GET WEATHER',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Carlito',
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.location_city),
                  hintText:
                      isCityNameEmpty ? 'City name (required)' : 'City name',
                  hintStyle: TextStyle(
                    color: isCityNameEmpty ? Colors.red : Colors.grey,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  //print(value);
                  setState(() {
                    cityName = value;
                    print(cityName);
                    isCityNameEmpty = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
