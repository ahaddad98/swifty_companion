import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // prefixIcon: Icon(Icons.send ,),
              suffixIcon: IconButton(
                onPressed: (() {
                  context.go('/page3');
                }),
                icon:Icon(Icons.send),
              ),
            ),
          ),
        )
      )
    );
  }
}
