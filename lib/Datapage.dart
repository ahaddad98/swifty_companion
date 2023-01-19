// import 'dart:html';

import 'dart:developer';

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

  var _iconbool = false;
  var _light_mode = Icons.light_mode;
  var _dark_mode = Icons.dark_mode;

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
      print(convert.jsonDecode(res.body));
      widget.leveltoshow =
          convert.jsonDecode(res.body)['cursus_users'][0]['level'];
      return convert.jsonDecode(res.body);
    } catch (e) {
      log('e');
      return {};
      // var uritmp = Uri.parse('https://api.intra.42.fr/v2/users/$login');
      // http.Response res = await http.get(uritmp, headers: {
      //   'Content-Type': 'application/json',
      //   'Accept': 'application/json',
      //   'Authorization': 'Bearer $refaction',
      // });
      // return convert.jsonDecode(res.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    var defaultTextStyle = TextStyle(
        color: !_iconbool ? Colors.black : Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto');
    return FutureBuilder(
      future: databaseFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData && snapshot.hasError) {
          return Center(
              child:  Container(child: const Text('User Not Found')));
        }
        if (snapshot.hasData) {
          print('snapshoot has data *-=============================');
          print(snapshot.data['cursus_users']);
          var items1 = <String>[];
          if (snapshot.data['cursus_users'] != null &&
              snapshot.data['cursus_users'].length == 2) {
            items1.add('Piscine');
            items1.add('42');
            if (widget.level == 0) {
              widget.level = snapshot.data['cursus_users'][1]['level'];
            }
          } else {
            items1.add('Piscine');
            if (widget.level == 0)
              widget.level = snapshot.data['cursus_users'][0]['level'];
          }
          String dropdownValue = items1.length == 2 ? '42' : 'Piscine';
          List<num> data = [];
          List<String> features = [];
          if (snapshot.data['cursus_users'] != null &&snapshot.data['cursus_users'].length == 2 &&  snapshot.data['cursus_users'][1]['skills'] != null) {
            for (var i = 0;
                i < snapshot.data['cursus_users'][1]['skills'].length;
                i++) {
              data.add(snapshot.data['cursus_users'][1]['skills'][i]['level']);
              features
                  .add(snapshot.data['cursus_users'][1]['skills'][i]['name']);
            }
          }
          return Scaffold(
            backgroundColor:
                !_iconbool ? Colors.white : Color.fromARGB(255, 52, 50, 83),
            appBar: AppBar(
              title: new Image.asset(
                'images/42.jpeg',
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
              backgroundColor:
                  !_iconbool ? Colors.white : Color.fromARGB(255, 52, 50, 83),
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
                    setState(() {
                      _iconbool = !_iconbool;
                    });
                    print('dark or light mode');
                  },
                  icon: Icon(
                    _iconbool ? _dark_mode : _light_mode,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            body: ListView(
              // backgroundColor:  !_iconbool ?   Colors.white : Color.fromARGB(255, 52, 50, 83),

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
                        Text(
                          'username',
                          style: defaultTextStyle,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Wallet',
                          style: defaultTextStyle,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Collision',
                          style: defaultTextStyle,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'correction_point',
                          style: defaultTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data['login'].toString(),
                          style: defaultTextStyle,
                        ),
                        SizedBox(height: 10),
                        Text(
                          snapshot.data['wallet'].toString(),
                          style: defaultTextStyle,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Collision',
                          style: defaultTextStyle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.data['correction_point'].toString(),
                          style: defaultTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  height: 60,
                  width: 100,
                  // color: !_iconbool ?   Colors.white : Color.fromARGB(255, 52, 50, 83),
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(),
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
                          style: defaultTextStyle,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                Percentind(
                    level: widget.level, leveltoshow: widget.leveltoshow),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Projects", style: defaultTextStyle),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: snapshot.data['projects_users'].length,
                    itemBuilder: (context, index) {
                      if (snapshot.data['projects_users'][index]
                              ["final_mark"] !=
                          null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data['projects_users'][index]
                                        ["project"]["name"]
                                    .toString(),
                                style: defaultTextStyle,
                                // style: TextStyle(
                                //     fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                snapshot.data['projects_users'][index]
                                        ["final_mark"]
                                    .toString(),
                                style: defaultTextStyle,
                                //       style: TextStyle(
                                //           fontSize: 14,
                                // fontWeight: FontWeight.w600)
                              ),
                            ],
                          ),
                        );
                      }
                      return Container(
                        height: 0,
                        // child: Text(''),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          print('------------------------------------------------');
          return Column(
            children: [
              Center(child: Text("USER NOT FOUNT GO GOME")),
            ],
          );
        } else if (snapshot.hasData && snapshot.data.lenth == 0) {
          print('------------------------------------------------');
          return Column(
            children: [
              Center(child: Text("USER NOT FOUNT GO GOME")),
            ],
          );
        }
        {
          return Scaffold(
            // body: Center(child: const Text('sdklfhsdlkfgh')),
            body: Center(child: const CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
