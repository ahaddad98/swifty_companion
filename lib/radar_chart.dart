import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class RadarChartTest extends StatefulWidget {
  var skills;
  int skill_length;
  List<String> features ;
  List<num> data;
  RadarChartTest({super.key, required this.skills, required this.skill_length,required this.data,required this.features});

  @override
  State<RadarChartTest> createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChartTest> {
  bool darkMode = false;
  bool useSides = false;
  double numberOfFeatures = 10;
  @override
  void initState() {
    numberOfFeatures = widget.skill_length.toDouble();
    // print(widget.skills);
    // numberOfFeatures = widget.skills?.length.toDouble();
    List<num> data = [];
    List<String> features = [];
    if (widget.skills != null) {
      for (var i = 0; i < widget.skills.length; i++) {
        data.add(widget.skills[i]['level']);
        features.add(widget.skills[i]['name']);
      }
      setState(() {
        widget.data = data;
        widget.features = features;
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    const ticks = [0, 5, 10, 15, 20];
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
