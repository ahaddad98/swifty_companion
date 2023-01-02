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
    final url = 'https://api.intra.42.fr/oauth/authorize?client_id=u-s4t2ud-4e07c639697d9451de605a04a8d877090de6a7b32834a0ccd2027acabe652c35&redirect_uri=com.example.swiftycompanion%3A%2F%2Fcallbacktest&response_type=code';
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
        print('jejejeje');
        var uritmp = Uri.parse('https://api.intra.42.fr/oauth/token');
        http.Response res = await http.post(
          uritmp,
          body:{
            'code': code,
            'client_id': 'u-s4t2ud-4e07c639697d9451de605a04a8d877090de6a7b32834a0ccd2027acabe652c35',
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
      print(e);
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
