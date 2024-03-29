// import 'dart:html';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swiftycompanion/Graphechart.dart';
import 'package:swiftycompanion/Percentbar.dart';
import 'package:swiftycompanion/SearchPage.dart';
import 'package:swiftycompanion/prefences.dart';
import 'package:swiftycompanion/provider_setup.dart';
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
  var iconbool;
  DataPage({super.key, this.index, this.iconbool});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  Future? databaseFuture;
  void _setLevelToShow(double lev) {
    setState(() {
      widget.leveltoshow = lev;
    });
  }

  // bool _iconbool = false;
  @override
  void initState() {
    final darkModeProvider = DarkModeProvider();
    // _iconbool = darkModeProvider.isDark;
    // print(" hehehehe ${widget}");
    // _iconbool = widget.iconbool;
    databaseFuture = getdata();
    // widget.leveltoshow = databaseFuture['cursus_users'][0]['level'];
  }

  var _light_mode = Icons.light_mode;
  var _dark_mode = Icons.dark_mode;

  // var data;
  Future getdata() async {
    final accesstoken = await MyPreferences.getAccessToken();
    final refreshToken = await MyPreferences.getRefreshToken();
    print('accesstoken  ==> ' + accesstoken.toString());
    print('refreshToken ==> ' + refreshToken.toString());
    final String login = widget.index;
    var uritmp = Uri.parse('https://api.intra.42.fr/v2/users/$login');
    http.Response res;
    var statushttp;
    try {
      http.Response res = await http.get(uritmp, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accesstoken',
      });
      print('111111111111111111111111111111');
      statushttp = res.statusCode;
      print('wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
      var tmp = await convert.jsonDecode(res.body);
      if (tmp['cursus_users'].length > 0) {
        _setLevelToShow(
            convert.jsonDecode(res.body)?['cursus_users']?[0]?['level']);
      }
      print(tmp);
      print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      return tmp;
      // return {};
    } catch (e) {
      print(
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' + e.toString());
      if (statushttp == 401) {
        res = await http.post(uritmp, body: {
          "grant_type": "refresh_token",
          "client_id": dotenv.env['CLIENT_API'],
          "client_secret": dotenv.env['SECRET_API'],
          "refresh_token": refreshToken,
        });
        http.Response res1 = await http.get(uritmp, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        });
        var tmp = await convert.jsonDecode(res1.body);
        if (tmp) return tmp;
      }
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    var defaultTextStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Roboto');
    final darkModeProvider = Provider.of<DarkModeProvider>(context);
    return FutureBuilder(
      future: databaseFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Scaffold(
                // appBar: AppBar(
                //   title: new Image.asset(
                //     'images/42.png',
                //     width: 80.0,
                //     height: 80.0,
                //     fit: BoxFit.cover,
                //   ),
                //   centerTitle: true,
                //   // elevation: 0.0,
                //   leading: IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => SearchPage(),
                //         ),
                //       );
                //     },
                //     icon: Icon(
                //       Icons.arrow_back,
                //       color: Colors.grey,
                //     ),
                //   ),
                //   actions: <Widget>[
                //     IconButton(
                //       onPressed: () {
                //         darkModeProvider.switchMode();
                //       },
                //       icon: Selector<DarkModeProvider, bool>(
                //         selector: (_, darkmp) => darkmp.isDark,
                //         builder: (_, isDark, __) => Icon(
                //           isDark ? _dark_mode : _light_mode,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                body: Center(child: Text("LOGIN NOT FOUND")));
          }
          var items1 = <String>[];
          if (snapshot.data?['cursus_users'] != null &&
              snapshot.data['cursus_users'].length == 2) {
            items1.add('Piscine');
            items1.add('42');
            if (widget.level == 0) {
              widget.level = snapshot.data?['cursus_users'][1]['level'];
            }
          } else {
            items1.add('Piscine');
            if (widget.level == 0 &&
                snapshot.data?['cursus_users'] != null &&
                snapshot.data['cursus_users'].length == 1) {
              widget.level = snapshot.data?['cursus_users'][0]['level'];
            }
          }
          String dropdownValue = items1.first;
          List<num> data = [];
          List<String> features = [];
          if (snapshot.data['cursus_users'] != null &&
              snapshot.data['cursus_users'].length == 2 &&
              snapshot.data['cursus_users'][1]['skills'] != null) {
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
                'images/42.png',
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
              centerTitle: true,
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
                    darkModeProvider.switchMode();
                  },
                  icon: Selector<DarkModeProvider, bool>(
                    selector: (_, darkmp) => darkmp.isDark,
                    builder: (_, isDark, __) => Icon(
                      isDark ? _dark_mode : _light_mode,
                      color: Colors.grey,
                    ),
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
                                Image.network(snapshot.data?['image']?['link']),
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
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(),
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      _setLevelToShow(newValue == '42'
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
                if (snapshot.data['projects_users'].length <= 0)
                  Center(child: Text('No projects'))
                else
                  Container(
                    height: snapshot.data['projects_users'].length < 7
                        ? snapshot.data['projects_users'].length * 40.0
                        : 250.0,
                    constraints: BoxConstraints(maxHeight: 250),
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
                                Expanded(
                                  child: Text(
                                    snapshot.data['projects_users'][index]
                                            ["project"]["name"]
                                        .toString(),
                                    style: defaultTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  snapshot.data['projects_users'][index]
                                          ["final_mark"]
                                      .toString(),
                                  style: defaultTextStyle,
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
                  ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Skills", style: defaultTextStyle),
                    ),
                  ],
                ),
                if (snapshot.data?['cursus_users'].length <= 0)
                  Center(child: Text('No Skills Found'))
                else
                  Column(
                    children: [
                      Container(
                        height: snapshot.data['cursus_users'].last['skills']
                                    .length <
                                2
                            ? snapshot.data['cursus_users'].last['skills']
                                    .length *
                                40.0
                            : 250.0,
                        constraints: BoxConstraints(maxHeight: 250),
                        child: ListView.builder(
                          itemCount: snapshot
                              .data['cursus_users'].last['skills'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data['cursus_users']
                                          .last['skills'][index]["name"]
                                          .toString(),
                                      style: defaultTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['cursus_users']
                                        .last['skills'][index]["level"]
                                        .toString(),
                                    style: defaultTextStyle,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Center(child: Text(snapshot.error.toString())),
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
