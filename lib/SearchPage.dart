import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _loginname;
  @override
  void initState() {
    _loginname = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _loginname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                context.go('/page3?index=$login');
              },
              ) 
          ),
        ),
      ),
    )));
  }
}
