import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'swiftycompanion',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.light_mode,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(child: Text('1212')),
    );
  }
}
