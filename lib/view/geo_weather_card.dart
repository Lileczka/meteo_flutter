import 'package:flutter/material.dart';

class GeoWidget extends StatelessWidget {
  const GeoWidget(this.city, this.temperature, this.localtime, {super.key});

  final String city;
  final double temperature;
  final String localtime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${temperature.toString()} °C',
        ),
        Text(
          'text avec icon',
        ),
        Text('city géolocalisé'),
        Text('temperature de city geolocalise)'),
      ],
    );
  }
}
