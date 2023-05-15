import 'package:flutter/material.dart';

class GeoWidget extends StatelessWidget {
  const GeoWidget(this.city, this.temperature, this.localtime, this.text,
      {super.key});

  final String city;
  final double temperature;
  final String localtime;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${temperature.toString()} °C',
        ),
        Text(
          'Temperature de $city',
        ),
        Text(
          'Today is:\n $localtime',
        ),
        Text(
          '$text',
        ),
      ],
    );
  }
}
