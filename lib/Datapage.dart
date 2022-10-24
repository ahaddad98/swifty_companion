// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swiftycompanion/Graphechart.dart';
import 'package:swiftycompanion/SearchPage.dart';
import 'package:swiftycompanion/radar_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class DataPage extends StatefulWidget {
  var index;
  DataPage({super.key, this.index});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  Future? databaseFuture;

  @override
  void initState() {
    databaseFuture = getdata();
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
    // setState(() {
    //      data = convert.jsonDecode(res.body);
    //      print(data);
    // });
  }
String dropdownvalue = 'Item 1';  
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    // getdata();

    return FutureBuilder(
      future: databaseFuture,
      builder: (context, snapshot) {
        print(snapshot.data['cursus_users'][0]);

        // print(snapshot.data['image']['link']);
        // final uri = Uri.parse('https://cdn.intra.42.fr/users/medium_ahaddad.jpg')
        // var file = File(uri);
        if (snapshot.hasData) {
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
                DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
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
                      Text(
                          'LEVEL : ${snapshot.data['cursus_users'][0]['level']}'),
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
        } else {
          return Text('data');
        }
      },
    );
  }
}
