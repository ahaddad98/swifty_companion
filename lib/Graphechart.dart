import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  GraphChart({Key? key}) : super(key: key);

  @override
  GraphChartState createState() => GraphChartState();
}

class GraphChartState extends State<GraphChart> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      //Initialize the chart widget
      SizedBox(
        height: 200,
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'Half yearly sales analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_SalesData, String>>[
              LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]),
      ),
    ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
