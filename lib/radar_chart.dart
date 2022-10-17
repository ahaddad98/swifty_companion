import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class RadarChartTest extends StatefulWidget {
  const RadarChartTest({super.key});

  @override
  State<RadarChartTest> createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChartTest> {
  bool darkMode = false;
  bool useSides = false;
  double numberOfFeatures = 20;
  @override
  Widget build(BuildContext context) {
    const ticks = [7, 14, 21, 28, 35];
    var features = ["AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH", "AA", "BB", "CC", "DD", "EE", "FF", "GG", "HH" , "AA", "BB", "CC", "DD", "EE"];
    var data = [
      [10.0, 20, 28, 5, 16, 15, 17, 6, 10.0, 20, 28, 5, 16, 15, 17, 6, 10.0, 20, 28, 5, 16],
    ];

    features = features.sublist(0, numberOfFeatures.floor());
    data = data
        .map((graph) => graph.sublist(0, numberOfFeatures.floor()))
        .toList();

    return Scaffold(
      body: Container(
        color: darkMode ? Color.fromARGB(255, 104, 102, 102) : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Skills'),
            Expanded(
              child: darkMode
                  ? RadarChart.dark(
                      ticks: ticks,
                      features: features,
                      data: data,
                      reverseAxis: true,
                      useSides: useSides,
                    )
                  : RadarChart.light(
                      ticks: ticks,
                      features: features,
                      data: data,
                      reverseAxis: true,
                      useSides: useSides,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}