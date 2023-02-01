import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:swiftycompanion/Datapage.dart';
import 'package:swiftycompanion/LoginPage.dart';
import 'package:swiftycompanion/prefences.dart';
import 'package:swiftycompanion/provider_setup.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _loginname;
  @override
  void initState() {
    final darkModeProvider = DarkModeProvider();
    _loginname = TextEditingController();
    super.initState();
  }

  var _light_mode = Icons.light_mode;
  var _dark_mode = Icons.dark_mode;
  @override
  void dispose() {
    _loginname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: new Image.asset(
            'images/42.png',
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () async {
              await MyPreferences.removeAccessToken();
              await MyPreferences.removeRefreshToken();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Loginpage(),
                ),
              );
            },
            icon: Icon(
              Icons.logout_rounded,
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
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextField(
            controller: _loginname,
            decoration: InputDecoration(
              hintText: 'Input Login',
              border: OutlineInputBorder(),
              // prefixIcon: Icon(Icons.send ,),
              suffixIcon: IconButton(
                  onPressed: (() {
                    final login = _loginname.text;
                    context.go('/page3?index=$login');
                  }),
                  icon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final login = _loginname.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DataPage(index: _loginname.text),
                        ),
                      );
                      // context.go('/page3?index=$login');
                    },
                  )),
            ),
          ),
        )));
  }
}
