// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swiftycompanion/Graphechart.dart';
import 'package:swiftycompanion/Percentbar.dart';
import 'package:swiftycompanion/SearchPage.dart';
import 'package:swiftycompanion/radar_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DataPage extends StatefulWidget {
  var index;
  var leveldouble = 95.0;
  var level = 0.0;
  var leveltoshow = 0.0;

  DataPage({super.key, this.index});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  Future? databaseFuture;
  void _incrementCounter(double lev) {
    setState(() {
      widget.leveltoshow = lev;
    });
  }

  @override
  void initState() {
    databaseFuture = getdata();
    // print(databaseFuture);
    // widget.leveltoshow = databaseFuture == '42' ? (databaseFuture.data['cursus_users'][1]['level']) : (databaseFuture.data['cursus_users'][0]['level']);
  }

  // var data;
  Future getdata() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('token');
    final String? refaction = prefs.getString('refreshtoken');
    final String login = widget.index;
    try {
      var uritmp = Uri.parse('https://api.intra.42.fr/v2/users/$login');
      http.Response res = await http.get(uritmp, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $action',
      });
      // print(convert.jsonDecode(res.body));
      widget.leveltoshow =
          convert.jsonDecode(res.body)['cursus_users'][0]['level'];
      return convert.jsonDecode(res.body);
    } catch (e) {
      var uritmp = Uri.parse('https://api.intra.42.fr/v2/users/$login');
      http.Response res = await http.get(uritmp, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $refaction',
      });
      return convert.jsonDecode(res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: databaseFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items1 = <String>[];
          if (snapshot.data['cursus_users'].length == 2) {
            items1.add('42');
            items1.add('Piscine');
          } else {
            items1.add('Piscine');
          }
          String dropdownValue = items1.length == 2 ? '42' : 'Piscine';
          List<num> data = [];
          List<String> features = [];
          if (snapshot.data['cursus_users'][1]['skills'] != null) {
            for (var i = 0;
                i < snapshot.data['cursus_users'][1]['skills'].length;
                i++) {
              data.add(snapshot.data['cursus_users'][1]['skills'][i]['level']);
              features
                  .add(snapshot.data['cursus_users'][1]['skills'][i]['name']);
            }
          }
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
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
                      child: new ListView(
                        children: [
                          ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(100.0),
                            child:
                                Image.network(snapshot.data['image']['link']),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('username'),
                        SizedBox(height: 10),
                        Text('Wallet'),
                        SizedBox(height: 10),
                        Text('Collision'),
                        SizedBox(height: 10),
                        Text('correction_point'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data['login'].toString()),
                        SizedBox(height: 10),
                        Text(snapshot.data['wallet'].toString()),
                        SizedBox(height: 10),
                        Text('Collision'),
                        SizedBox(height: 10),
                        Text(snapshot.data['correction_point'].toString()),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  height: 60,
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      _incrementCounter(newValue == '42'
                          ? (snapshot.data['cursus_users'][1]['level'])
                          : (snapshot.data['cursus_users'][0]['level']));
                    },
                    items: items1.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 15),
                Percentind(
                    level: widget.level, leveltoshow: widget.leveltoshow),
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
        } else {
          return Scaffold(
            body: Center(child: const CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
