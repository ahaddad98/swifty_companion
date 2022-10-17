import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swiftycompanion/Graphechart.dart';
import 'package:swiftycompanion/radar_chart.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Image.asset(
          'images/42.jpeg',
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        // elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            context.go('/page2');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
             print('dark or light mode');
            },
            icon: const Icon(
              Icons.light_mode,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: GraphChart(),
      // ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                width: 120,
                height: 120,
                child: Image.asset('images/86.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('username'),
                  SizedBox(height: 10),
                  Text('Wallet'),
                  SizedBox(height: 10),
                  Text('Collision'),
                ],
              )
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('LEVEL : 10'),
              ],
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 200,
                // child: GraphChart()
                child: RadarChartTest(),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Projects'),
                Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('Project_name'), Text('100')],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('Project_name'), Text('100')],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
