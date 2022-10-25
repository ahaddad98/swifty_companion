import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class RadarChartTest extends StatefulWidget {
  var skills;
  List<String> features = [];
  List<num> data = [];
   RadarChartTest({super.key, required this.skills});

  @override
  State<RadarChartTest> createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChartTest> {
  bool darkMode = false;
  bool useSides = false;
  double numberOfFeatures = 40;
  @override
  void initState() {
    numberOfFeatures = widget.skills.length.toDouble();
    for (var i = 0; i < widget.skills.length ; i++) {
      widget.data.add(widget.skills[i]['level']);
      widget.features.add(widget.skills[i]['name']);
    }
    print(widget.data);
  }
  @override
  Widget build(BuildContext context) {
    const ticks = [0,5, 10,15,20];
    var features = widget.features;
    var data = [
      widget.data,
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