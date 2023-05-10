import 'package:flutter/material.dart';

class Localisation extends StatefulWidget {
  const Localisation({super.key});

  @override
  State<Localisation> createState() => _Localisation();
}

class _Localisation extends State<Localisation> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/localisation');
                    },
                    icon: const Icon(Icons.near_me, size: 50),
                    color: const Color.fromARGB(255, 226, 147, 29),
                  ),
                  IconButton(
                    onPressed: () {
                      print('clik');
                      //Navigator.pushNamed(context, '/');
                    },
                    icon: const Icon(Icons.location_city, size: 50),
                    color: const Color.fromARGB(255, 226, 147, 29),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: const <Widget>[
                        Text('12°C'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: const <Widget>[
                        Text('TEXT'),
                      ],
                    ),
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
