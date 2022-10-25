import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swiftycompanion/Graphechart.dart';
import 'package:swiftycompanion/SearchPage.dart';
import 'package:swiftycompanion/radar_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Percentind extends StatefulWidget {
  double level;
  double leveltoshow;
  Percentind({super.key,required this.level, required this.leveltoshow});
  
  @override
  State<Percentind> createState() => _PercentindState();
}

class _PercentindState extends State<Percentind> {
  
  @override
  void initState() {
    super.initState();
    print(widget.level);
  }

  @override
  Widget build(BuildContext context) {
    // print('in widget${widget.leveltoshow}');
    var level = (widget.leveltoshow.toDouble() - widget.leveltoshow.toInt());
    print('in widget${level}');
    return Container(
      child: new LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 30,
        animation: true,
        lineHeight: 20.0,
        animationDuration: 1000,
        percent: level,
        center: Text('Level ${widget.leveltoshow}'),
        barRadius: Radius.circular(10),
        progressColor: Colors.greenAccent,
      ),
    );
  }
}
