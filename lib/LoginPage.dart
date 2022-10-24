import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftycompanion/SearchPage.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  void authenticate(BuildContext context ) async {
    final url = 'https://api.intra.42.fr/oauth/authorize?client_id=u-s4t2ud-1bb996bf6d9b8215ae9f5a2eb4c810988202915bbc30244d37ed254ae3952649&redirect_uri=com.example.swiftycompanion%3A%2F%2Fcallbacktest&response_type=code';
    final callbackUrlScheme = 'com.example.swiftycompanion';
    final prefs = await SharedPreferences.getInstance();
    var arr = [];
    try {
      final result = await FlutterWebAuth.authenticate(url: url, callbackUrlScheme: callbackUrlScheme);
      arr = result.split('code=');
      final String code;
      if (!arr.isEmpty)
      {
        code = arr[1];
        log('code =  $code');
        var uritmp = Uri.parse('https://api.intra.42.fr/oauth/token');
        http.Response res = await http.post(
          uritmp,
          body:{
            'code': code,
            'client_id': 'u-s4t2ud-1bb996bf6d9b8215ae9f5a2eb4c810988202915bbc30244d37ed254ae3952649',
            'client_secret': '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',
            'redirect_uri': 'com.example.swiftycompanion://callbacktest',
            'grant_type': 'authorization_code',
          },
        );
        var a = convert.jsonDecode(res.body);
        var reftoken;
        await prefs.setString('token', a['access_token']);
        await prefs.setString('refreshtoken', a['refresh_token']);
        print(res.body);        
        context.go('/page2');
      }
    } on PlatformException catch (e) {
      // setState(() {
      //    print('token');
      //    _status = 'Got error: $e'; 
      //    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              child: new Image.asset(
                'images/42.jpeg',
                width: 300.0,
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      this.authenticate(context);
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => SearchPage(
                          )
                          )
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
